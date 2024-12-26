class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
  
    protected
  
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
    end
  
    def build_resource(hash = {})
      hash[:role] ||= 'customer' # Default role for new sign-ups
      super
    end
  end
  