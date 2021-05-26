require 'money-rails'
require 'stripe'

class AppointmentsController < ApplicationController
  def index
    @user = current_user
    @all_appointments = Appointment.with_deleted.where(user: @user)
    @unaccepted_appointments = Appointment.where(status: false, user: @user).order(when: :desc)
    @accepted_appointments = Appointment.where(status: true, user: @user, payment_status: 'pending').order(when: :desc)
    @confirmed_appointments = Appointment.where(payment_status: 'paid', user: @user).order(when: :desc)
    @deleted_appointments = Appointment.only_deleted.where(user: @user)
  end

  def consulation
  end

  def show
    @appointment = Appointment.find(params[:id])

    if @appointment.user == current_user || @appointment.master == current_user
      if @appointment.payment_status == 'paid'
        @master = @appointment.master
        @user = @appointment.user
        @room_name = "#{@master.email} x #{@user.email}"

        # Required for any Twilio Access Token
        account_sid = ENV['TWILIO_ACCOUNT_SID']
        api_key = ENV['TWILIO_API_KEY_SID']
        api_secret = ENV['TWILIO_API_SECRET']

        identity = current_user.email

        # Create an Access Token
        token = Twilio::JWT::AccessToken.new(account_sid, api_key, api_secret, [], identity: identity)

        # Create Video grant for our token
        grant = Twilio::JWT::AccessToken::VideoGrant.new
        grant.room = @room_name
        token.add_grant(grant)

        # Generate the token
        @access_token = token.to_jwt
      else
        redirect_to appointments_path, notice: 'This appointment has not been paid for yet.'
      end
    else
      redirect_to appointments_path, notice: 'You are not authorized to see this appointment.'
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    @appointment.status = true
    @appointment.payment_status = 'pending'

    @master = @appointment.master
    @appointment.amount = @master.price

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: @master.email,
        amount: @master.price_cents,
        currency: 'sgd',
        quantity: 1
      }],
      # livemode: false,
      success_url: user_url(@master),
      cancel_url: user_url(@master)
    )

    @appointment.checkout_session_id = session.id

    @appointment.save

    redirect_to dashboard_path
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to dashboard_path
  end

  def really_destroy
    @appointment = Appointment.only_deleted.find(params[:id])
    @appointment.really_destroy!
    redirect_to appointments_path
    flash.alert = "Appointment deleted."
  end
end
