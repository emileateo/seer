class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    @birthdate = params[:birthdate]
    super
    # raise
  end

  def create
    @birthdate = params[:birthdate]
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:birthdate])
  end

  def after_sign_up_path_for(resource)
    preferences_path
  end
end
