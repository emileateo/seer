class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def masters
    @masters = User.where(master: true)
  end

  def show
    @master = User.find(params[:id])
    @appointment = Appointment.new
  end

  def update
    @user = User.find(params[:id])
    @preferences_array = params[:user][:preferences]
    @preferences_array.delete_at(0)
    @preferences_array.each do |category|
      @user.categories << Category.find(category.to_i)
    end
    redirect_to dashboard_path
  end

  def appointments
    @appointment = Appointment.new(appointment_params)
    @master = User.find(params[:id])
    @appointment.master = @master
    @appointment.user = current_user
    @appointment.status = false
    if @appointment.save
      redirect_to root_path, notice: "We\'ve sent a request to #{@appointment.master.email}!"
    else
      render :show
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:message, :when, :id)
  end

  def user_params
    params.require(:user).permit(:email, :id, :master, :specialty)
  end
end

