class ListsController < ApplicationController
  before_action :set_list, only: [:edit, :destroy, :show]

  def add_to_queue
    @queue = current_queue
    @queue.save if @queue.id.nil?
    session[:list_id] = @queue.id

    if !Movie.find_by(tmdb_id: params[:tmdb_id])
      self.save
    end

    @queue.movies << Movie.find_by(tmdb_id: params[:tmdb_id])
    redirect_to details_path(id: params[:tmdb_id])
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
    movie = Movie.new() if movie.nil?

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
  end

  def remove_movie
    MoviesList.find_by(list_id: params[:list_id], movie_id: params[:id]).delete
    show # (list_id: params[:list_id])
    render :show
  end

  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_path, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def all
    @lists = current_user.lists
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
  end

  def delete
  end

  private

    def set_list
      @list = List.find(params[:id]) || List.new
    end

    def list_params
      params.require(:list).permit(:name, :user_id)
    end
end
