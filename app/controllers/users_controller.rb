class UsersController < ApplicationController
  def update
    @user = User.find(params[:id])
    @preferences_array = params[:user][:preferences]
    @preferences_array.delete_at(0)
    @preferences_array.each do |category|
      Preference.create(user: current_user, category_id: category.to_i)
    end
    redirect_to root_path
  end
end
