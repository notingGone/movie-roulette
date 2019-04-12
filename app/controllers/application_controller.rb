class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  helper_method :current_queue

  def current_queue
    # create a list that is descriptive and nearly impossible for the user to
    # 'accidentally' enter for the name of their list
    queue_list_name = "\u009E#{current_user.username}'s (#{current_user.id}:) queue"
    List.find_or_create_by(user_id: current_user.id, name: queue_list_name)
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email])
    end
end
