class RegistrationsController < Devise::RegistrationsController
  def new
    super
    # raise
  end

  def create
    super
  end

  protected

  def after_sign_up_path_for(resource)
    preferences_path
  end
end
