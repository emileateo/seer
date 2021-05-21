class AppointmentsController < ApplicationController
  def index
    @user = current_user
    @unaccepted_appointments = Appointment.where(status: false, user: @user).order(when: :desc)
    @accepted_appointments = Appointment.where(status: true, user: @user).order(when: :desc)
  end

  def show
    # @appointments =
  end
end
