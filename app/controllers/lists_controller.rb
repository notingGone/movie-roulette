class ListsController < ApplicationController
  before_action :set_list, only:
    [:roulette, :destroy, :filter, :remove_movie]

  def roulette
  end

  def spin
    @winner = @queue.movies.to_a.sample
  end

  def filter
  end

  def add_to_queue
    MoviesList.where(list_id: current_user.list.id).where(movie_id: params[:movie_id]).update(queue: true)

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
    current_user.list.movies <<
                 Movie.find_by(tmdb_id: params[:tmdb_id])
    redirect_to details_path(tmdb_id: params[:tmdb_id])
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

    def list_params
      params.require(:list).permit(:name, :user_id)
    end
end
