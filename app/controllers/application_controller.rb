class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  private

  def configure_permitted_parameters
    [:sign_up, :account_update].each do |action|
      devise_parameter_sanitizer.permit(action, keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday])
    end
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
