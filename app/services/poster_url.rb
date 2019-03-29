class PosterUrl
  attr_reader :movie, :path
  def initialize(movie)
    @movie = movie
    @path = CONFIG.images.secure_base_url +
            CONFIG.images.poster_sizes.first +
            movie.poster_path
  end
end
