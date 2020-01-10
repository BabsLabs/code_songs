class SongifyService

  def initialize(user, cart)
    @token = user.token
    @login = user.login
    @repo = cart.repo
    @artist_id = cart.artist_id
    @heroku_url = 'https://code-songs-microservice.herokuapp.com'
  end

  def home
    response = conn.get('/')
    response.body
  end

  def match_songs
    response = conn.get('/codesongs_matcher') do |req|
      req.headers = {'login'=> @login, 'repo'=> @repo, 'token'=>@token, 'artist_id'=> @artist_id}
    end
    json = response.body.to_json
    r = JSON.parse(json, :quirks_mode => true)
    JSON.parse(r, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: @heroku_url) do |f|
      f.adapter Faraday.default_adapter
    end
  end
end
