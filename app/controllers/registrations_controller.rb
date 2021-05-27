class RegistrationsController < Devise::RegistrationsController
   before_action :configure_permitted_parameters, if: :devise_controller?
  def new
    @name = params[:name]
    @birth_date = params[:birthdate]
    super
    # raise
  end

  def create
    @name = params[:name]
    @birth_date = params[:birthdate]
    raise
    super
  end

  protected

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birthdate])
  end

  def after_sign_up_path_for(resource)
    preferences_path
  end
end
