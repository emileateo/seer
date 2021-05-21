class RegistrationsController < Devise::RegistrationsController
  def new
    @birthdate = params[:birthdate]
    super
  end

  protected

  def after_sign_up_path_for(resource)
    preferences_path
  end
end
