class AppointmentsController < ApplicationController
  def index
    @user = current_user
    @unaccepted_appointments = Appointment.where(status: false, user: @user).order(when: :desc)
    @accepted_appointments = Appointment.where(status: true, user: @user).order(when: :desc)
  end

<<<<<<< HEAD
  def consulation
=======
  def show
    # @appointments =
>>>>>>> 1c819f5241cf9c099caace998f6bbd750b74eca8
  end
end
