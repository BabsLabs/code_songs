class SongifyService

  def initialize(user, cart)
    @token = user.token
    @login = user.login
    @repo = cart.repo
    @artist_id = cart.artist_id
    @heroku_url = 'https://code-songs-microservice.herokuapp.com'
    @local_host = 'http://localhost:9292'
  end

  def home
    response = conn.get('/')
    response.body
  end

  def match_songs
    response = conn.get('/codesongs_matcher') do |req|
      req.headers = {'login'=> @login, 'repo'=> @repo, 'token'=>@token, 'artist_id'=> @artist_id}
    end
    collection = JSON.parse(response.body)
    binding.pry
  end

  private

  def conn
    Faraday.new(url: @local_host) do |f|
      f.adapter Faraday.default_adapter
    end
  end
end
