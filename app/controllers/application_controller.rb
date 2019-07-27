class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters,
    if: :devise_controller?
  before_action :set_queue, only:
    [:roulette, :queue, :remove_movie, :add_to_queue, :spin]
  before_action :set_movie, only: [:remove_movie, :details]
  before_action :set_list, only: [:details, :roulette, :add_to_queue]
  before_action :save, only: :details

  private

    def save
      details = Tmdb::Movie.detail(params[:tmdb_id])
      movie = Movie.new()

      movie.title = details.title
      movie.overview = details.overview
      movie.tagline = details.tagline
      movie.tmdb_id = details.id
      movie.homepage = details.homepage
      movie.adult = details.adult
      movie.runtime = details.runtime
      movie.imdb_id = details.imdb_id
      movie.poster_path = details.poster_path
      movie.popularity = details.popularity
      movie.save
      movie
    end

    def set_list
      @list = current_user.list.movies
    end

    def set_queue
      queue_ids = MoviesList.where(list_id: current_user.list.id).where(queue: true).pluck(:movie_id)
      @queue = Movie.find(queue_ids)
    end

    def set_movie
      this_movie_id = params[:id].nil? ? params[:tmdb_id] : params[:id]
      @movie = Movie.find_by(tmdb_id: this_movie_id)
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email])
    end
end
