class GenreSerializer

  def initialize(genre_obj)
    @genre = genre_obj
  end

  def to_serialized_json
    options = {
      only: [:name]
    }
    @genre.to_json(options)
  end

end