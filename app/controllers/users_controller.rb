class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  # def index
  #   @users = User.where(master: true)
  #   @master_list = []
  #   @users.each do |user|
  #     @master_list << user
  #   end
  # end

  def masters
    @masters = User.where(master: true)
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :id, :master, :specialty)
  end
end
