class ApplicationController < ActionController::Base
  # 追加
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  def after_sign_in_path_for(resource)
    end_user_path(resource)
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :public
       root_path
    elsif resource_or_scope == :admin
       new_admin_session_path
    else
       about_path
    end
  end

end