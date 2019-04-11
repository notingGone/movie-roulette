class MoviesController < ApplicationController
  before_action :set_movie, only: [:edit, :update]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  def search
  end

  def edit
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  def details
    if (@movie = Movie.find_by(tmdb_id: params[:tmdb_id])).nil?
      @movie = Tmdb::Movie.detail(params[:tmdb_id])
      @not_saved = true
    end
  end

  def search_results
    @movies = Tmdb::Search.movie(params[:query], include_adult: params[:include_adult])
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @movie = Movie.find_by(tmdb_id: params[:tmdb_id]).attributes
    if @movie.nil?
      @movie = Tmdb::Movie.detail(params[:tmdb_id])
      @not_saved = true
    end
  end

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
