class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def after_sign_in_path_for(resource)
    if current_user.admin? || current_user.seller?
      Trestle.config.path
    else
      root_path
    end
  end

  def after_sign_up_path_for(resource)
    root_path # or any other path like '/dashboard'
  end
end