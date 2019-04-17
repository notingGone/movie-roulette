class ListsController < ApplicationController
  before_action :set_list, only:
    [:roulette, :destroy, :filter, :remove_movie]


  def roulette
  end

  def spin
    @winner = @queue.movies.to_a.sample
  end

  def queue
  end

  def filter
  end

  def add_to_queue
    # debugger
    this_movie_id = params[:id].nil? ? params[:tmdb_id] : params[:id]
    if !(movie = Movie.find_by(tmdb_id: this_movie_id))
      movie = self.save
    end
    if !@queue.to_a.pluck(:tmdb_id).include? this_movie_id
      current_user.list.movies << movie
    end
    current_user.movies_lists.find_by(movie_id: this_movie_id).update(queue: true)
    # redirect_to details_path(tmdb_id: params[:tmdb_id])
    set_queue
    set_list
    set_movie
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
  end

  def add
    if !Movie.find_by(tmdb_id: params[:tmdb_id])
      self.save
    end
    current_user.lists.find_by(id: params[:list_id]).movies <<
                 Movie.find_by(tmdb_id: params[:tmdb_id])
    redirect_to details_path(tmdb_id: params[:tmdb_id])
  end

  def save
    debugger
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

  def remove_movie
    movie = current_user.movies_lists.find_by(movie_id: params[:movie_id])
    if movie.queue
      movie.update(queue: false)
    else
      MoviesList.find_by(list_id: current_user.list, movie_id: params[:movie_id]).delete
    end
    @movie = params[:movie_id]
    set_queue
    set_list
  end

  # def show
  #   @list = List.find(params[:list_id])
  # end

  private

    def set_list
      @list = current_user.list.movies
    end

    def list_params
      params.require(:list).permit(:name, :user_id)
    end
end
