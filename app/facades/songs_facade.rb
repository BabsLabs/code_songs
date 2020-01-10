class SongsFacade
  attr_reader :songs, :artist_name, :repo

  def initialize(current_user, songify_cart)
    @user = current_user
    @cart = songify_cart
    @artist_name = songify_cart.artist_name
    @repo = songify_cart.repo
    @songs = songs_array
  end

  def fetch_matching_songs
    service = SongifyService.new(@user, @cart)
    service.match_songs
  end

  def songs_array
    fetch_matching_songs[:songs].map do |info|
      Song.new(info)
    end
  end
end
