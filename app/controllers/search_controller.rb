class SearchController < ApplicationController

  def details
    @movie = Tmdb::Movie.detail(params[:id])
    # debugger
    @not_saved = Movie.find_by(tmdb_id: params[:id]).nil?
    # @movie = Tmdb::Movie.detail(135397)
    # @movie = Movie.new(Tmdb::Movie.detail(24))
    # @poster_url = PosterUrl.new(@movie).path
  end

  def search_results
    # @movies = Movie.all
    # debugger
    @movies = Tmdb::Search.movie(params[:keywords])
  end

  def add
    if !Movie.find_by(tmdb_id: params[:id])
      # Movie.
    end
    current_user.lists.find_by(id: params[:list_id]) <<
                 Movie.find_by(tmdb_id: params[:id])
  end

  def search
    # @search = MovieSearch.new
  end

  def save
    # attributes = [ :title, :overview, :tagline, :tmdb_id, :homepage,
    #              :runtime, :imdb_id, :poster_path, :popularity ]
    # debugger
    details = Tmdb::Movie.detail(params[:id])
    #             attributes.include? key
    #           end
    # debugger
    movie = Movie.new()

    movie.title = details.title
    movie.overview = details.overview
    movie.tagline = details.tagline
    movie.tmdb_id = details.id
    movie.homepage = details.homepage
    # movie.release_date = details.release_date
    movie.runtime = details.runtime
    movie.imdb_id = details.imdb_id
    movie.poster_path = details.poster_path
    movie.popularity = details.popularity
    movie.save

    redirect_to details_path(id: params[:id])

  end

  private

  def search_params
    params.require(:keywords, :id)
  end

end
