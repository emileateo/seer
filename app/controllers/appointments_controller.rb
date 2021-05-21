class AppointmentsController < ApplicationController
  def index
    @user = current_user
    @unaccepted_appointments = Appointment.where(status: false, user: @user).order(when: :desc)
    @accepted_appointments = Appointment.where(status: true, user: @user).order(when: :desc)
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
end
