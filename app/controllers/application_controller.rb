class ApplicationController < ActionController::Base

  # 追加
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Bootstrapに用意されているスタイルのフラッシュを定義
  add_flash_types :success, :info, :warning, :danger

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

end