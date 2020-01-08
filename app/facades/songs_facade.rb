class SongsFacade
  attr_reader :songs, :artist_name, :repo

  def initialize(current_user, songify_cart)
    @login = current_user.login
    @token = current_user.token
    @artist_name = songify_cart.artist_name
    @artist_id = songify_cart.artist_id
    @repo = songify_cart.repo
    @songs = songs_array
  end

  def fetch_matching_songs
    # service = MatcherService.new
    # service.fetch_songs(@login, @token, @artist_id, @repo, @artist_name)

    # Expect format of information returned from microservice below.
    # Delete when MatcherService is implemented and running:
    [ {title: 'Hound Dog', link: 'mock_link_hd'},
      {title: "Can't Help Falling in Love", link: 'mock_link_love'},
      {title: 'Suspicious Minds', link: 'mock_link_minds'},
      {title: 'Jailhouse Rock', link: 'mock_link_jail'},
      {title: 'Blue Hawaii', link: 'mock_link_hawaii'} ]
  end

  def songs_array
    fetch_matching_songs.map do |info|
      Song.new(info)
    end
  end
end
