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
    # @appointments =
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
