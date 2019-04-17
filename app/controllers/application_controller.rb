class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters,
    if: :devise_controller?
  before_action :set_queue, only:
    [:roulette, :queue, :remove_movie, :add_to_queue, :details]
  before_action :set_movie, only: :remove_movie

  private

    def set_queue
      temp = current_user.movies_lists.where(queue: true).pluck(:movie_id)
      @queue = (List.new().movies << Movie.find(temp))
    end

    def set_movie
      @movie = Movie.find(params[:movie_id]) unless Movie.find(params[:movie_id]).nil?
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email])
    end
end
