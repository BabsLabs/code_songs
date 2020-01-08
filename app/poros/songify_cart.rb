class SongifyCart
  attr_reader :info

  def initialize(session_cart)
    @info = session_cart
  end

  def repo
    @info['repo']
  end

  def add_repo(repo)
    @info['repo'] = repo
  end

  def artist_name
    @info['artist_name']
  end

  def artist_id
    @info['artist_id']
  end

  def add_artist(artist_name, artist_id)
    @info['artist_name'] = artist_name
    @info['artist_id'] = artist_id
  end
end