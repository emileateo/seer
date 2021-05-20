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
  
  def update
    @user = User.find(params[:id])
    @preferences_array = params[:user][:preferences]
    @preferences_array.delete_at(0)
    @preferences_array.each do |category|
      @user.categories << Category.find(category.to_i)
    end
    redirect_to dashboard_path
  end
end
