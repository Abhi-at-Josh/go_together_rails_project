class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    admin_users_path # Redirect to admin panel after successful signup
  end
end
