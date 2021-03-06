class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, unless: :devise_controller?

  private

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation,
                  :demand_email]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def login_required
    redirect_to new_user_session_path, notice: "ログインしてください" unless current_user
  end

  def store_current_location
    return if current_user
    store_location_for(:user, request.url)
  end
end
