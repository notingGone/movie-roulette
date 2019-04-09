class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  def search
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  def details
    if (Movie.find_by(tmdb_id: params[:id])).nil?
      @movie = Tmdb::Movie.detail(params[:id], include_adult: params[:include_adult])
      @not_saved = true
    end
    # @not_saved = Movie.find_by(tmdb_id: params[:id]).nil?
  end

  def save
    # attributes = [ :title, :overview, :tagline, :tmdb_id, :homepage,
    #              :runtime, :imdb_id, :poster_path, :popularity ]
    details = Tmdb::Movie.detail(params[:id])
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
  end

  def search_results
    @movies = Tmdb::Search.movie(params[:query], include_adult: params[:include_adult])
  end

  def add
    if !Movie.find_by(tmdb_id: params[:id])
      self.save
    end
    current_user.lists.find_by(id: params[:list_id]).movies <<
                 Movie.find_by(tmdb_id: params[:id])
    redirect_to details_path(id: params[:id])
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @movie = Tmdb::Movie.detail(params[:id])
    @not_saved = Movie.find_by(tmdb_id: params[:id]).nil?
  end


  # # GET /movies/1/edit
  # def edit
  # end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id]) unless Movie.find(params[:id]).nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:id, :imdb_id, :title, :overview, :poster_path, :runtime, :tagline, :tmdb_id, :homepage, :popularity, :vote_average, :adult)
    end
end
