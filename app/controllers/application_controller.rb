class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  helper_method :current_queue

  def current_queue
    if session[:list_id]
      List.find(session[:list_id])
    else
      user_signed_in? ? List.create(user_id: current_user.id) : List.new
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email])
    end
end
