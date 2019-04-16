class ListsController < ApplicationController
  before_action :set_list, only: [:roulette, :edit, :destroy, :filter, :add_to_queue, :remove_movie]
  before_action :set_queue, only: [:roulette, :queue, :add_to_queue, :remove_movie, :show]

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
    if !(movie = Movie.find_by(tmdb_id: params[:tmdb_id]))
      movie = self.save
    end
    @current_user.list.movies << movie
    @current_user.list.movies.find_by(id: movie.id).update(queue: true)
    # redirect_to details_path(tmdb_id: params[:tmdb_id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List created successfully.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: unprocessable_entity }
      end
    end
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
    # attributes = [ :title, :overview, :tagline, :tmdb_id, :homepage,
    #              :runtime, :imdb_id, :poster_path, :popularity ]
    details = Tmdb::Movie.detail(params[:tmdb_id])
    #             attributes.include? key
    #           end
    movie = Movie.new()

    movie.title = details.title
    movie.overview = details.overview
    movie.tagline = details.tagline
    movie.tmdb_id = details.id
    movie.homepage = details.homepage
    movie.adult = details.adult
    # movie.release_date = details.release_date
    movie.runtime = details.runtime
    movie.imdb_id = details.imdb_id
    movie.poster_path = details.poster_path
    movie.popularity = details.popularity
    movie.save
    movie
  end

  def remove_movie
    MoviesList.find_by(list_id: params[:list_id], movie_id: params[:movie_id]).delete
  end

  def destroy
    @list.destroy
  end

  def all
    @lists = current_user.list
  end

  def show
    @list = List.find(params[:list_id])
  end

  def edit
  end

  def delete
  end

  private

    def set_queue
      # debugger
      temp = current_user.movies_lists.where(queue: true).pluck(:movie_id)
      @queue = (List.new().movies << Movie.find(temp))
    end


    def set_list
      @list = current_user.list.movies
    end

    def list_params
      params.require(:list).permit(:name, :user_id)
    end
end
