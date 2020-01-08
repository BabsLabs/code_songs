class Artist
  attr_reader :name,
              :id

  def initialize(args)
    @name = args[:artist_name]
    @id = args[:artist_id]
  end
end