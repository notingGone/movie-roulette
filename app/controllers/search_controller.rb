class SearchController < ApplicationController

  def details
    @movie = Tmdb::Movie.detail(24)
    # @movie = Tmdb::Movie.detail(135397)
    # @movie = Movie.new(Tmdb::Movie.detail(24))
    # @poster_url = PosterUrl.new(@movie).path
  end

  def search_results
    # @movies = Movie.all
    # debugger
    @movies = Tmdb::Search.movie(params[:keywords])
  end

  def search
    # @search = MovieSearch.new
  end

  private

  def search_params
    params.require(:keywords)
  end
end
