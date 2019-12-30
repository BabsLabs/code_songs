class SongifyCart
  attr_reader :repo,
              :artist_name,
              :artist_id

  def initialize
    @repo   = nil
    @artist_name = nil
    @artist_id = nil
  end

  def add_repo(repo)
    @repo = repo
  end

  def add_artist(artist_name, artist_id)
    @artist_name = artist_name
    @artist_id = artist_id
  end
end