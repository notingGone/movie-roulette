json.extract! movie, :id, :imdb_id, :title, :overview, :poster_path, :runtime, :tagline, :created_at, :updated_at
json.url movie_url(movie, format: :json)
