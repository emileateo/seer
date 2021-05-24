class AppointmentsController < ApplicationController
  def index
    @user = current_user
    @all_appointments = Appointment.with_deleted.where(user: @user)
    @unaccepted_appointments = Appointment.where(status: false, user: @user).order(when: :desc)
    @accepted_appointments = Appointment.where(status: true, user: @user).order(when: :desc)
    @deleted_appointments = Appointment.only_deleted.where(user: @user)
  end

  def consulation
  end

  def show
    # @appointments =
  end

  def update
    @appointment = Appointment.find(params[:id])
    @appointment.toggle(:status)
    @appointment.save
    redirect_to dashboard_path
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to dashboard_path
  end
end
