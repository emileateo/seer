class PaymentsController < ApplicationController
  def new
    @appointment = current_user.appointments.where(payment_status: 'pending').find(params[:appointment_id])
  end
end
