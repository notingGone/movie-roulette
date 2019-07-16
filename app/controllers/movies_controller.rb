
class MoviesController < ApplicationController

  def search
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  def details
    if (@movie = Movie.find_by(tmdb_id: params[:tmdb_id])).nil?
      @movie = Tmdb::Movie.detail(params[:tmdb_id])
      @not_saved = true
    else
      @movie = @movie.attributes
    end
  end

  def search_results
    @movies = Tmdb::Search.movie(params[:query], include_adult: params[:include_adult])
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:id, :imdb_id, :title, :overview, :poster_path, :runtime, :tagline, :tmdb_id, :homepage, :popularity, :vote_average, :adult)
    end
end
