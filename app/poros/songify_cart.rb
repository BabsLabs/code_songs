class SongifyCart
  attr_reader :repo,
              :artist

  def initialize
    @repo   = nil
    @artist = nil
  end

  def add_repo(repo)
    @repo = repo
  end

  def add_artist(artist)
    @artist = artist
  end
end