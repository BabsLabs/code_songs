class SongifyService

  def initialize(user, cart)
    @token = user.token
    @login = user.login
    @repo = cart.repo
    @artist_id = cart.artist_id
  end

  def home
    response = conn.get('/')
    response.body
  end

  def conn
    Faraday.new(url: 'https://code-songs-microservice.herokuapp.com') do |f|
      f.adapter Faraday.default_adapter
    end
  end
end
