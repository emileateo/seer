class AppointmentsController < ApplicationController
  def index
    @appointments = Appointments.all
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.master = user.find(params[:master_id])
    @appointment.user = current_user
    @appointment.status = false
      if params[:user_id][:master_id].present?
       redirect_to (root_path), notice: "We\'ve sent a request to #{@appointment.master.email}!" if @appointment.save!
      else
        render 'user/show'
      end
  end

  def approve
  end

  def consulation
  end

  private


  def appointment_params
    params.require(:appointment).permit(
      :message, :when)
  end
end
