module SearchHelper
  def small_movie_poster_url(movie)
    # debugger
    CONFIG.images.secure_base_url +
    CONFIG.images.poster_sizes.first +
    if movie['poster_path']
      movie['poster_path']
    else
      movie.poster_path
    end
  end
end
