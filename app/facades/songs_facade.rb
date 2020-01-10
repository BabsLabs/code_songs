class SongsFacade
  attr_reader :songs, :artist_name, :repo, :error

  def initialize(current_user, songify_cart)
    @user = current_user
    @cart = songify_cart
    @artist_name = songify_cart.artist_name
    @repo = songify_cart.repo
    @error = nil
    @songs = songs_array
  end

  def fetch_matching_songs
    service = SongifyService.new(@user, @cart)
    @response ||= service.match_songs

    if @response == [{:error=>"Artist has no tracks."}]
      @error = @response.first[:error]
    end
    
    @response
  end

  def songs_array
    songs_results = fetch_matching_songs
    unless songs_results == [{:error=>"Artist has no tracks."}]
      songs_results[:songs].map do |info|
        Song.new(info)
      end
    end
  end
end
