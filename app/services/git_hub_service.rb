class GitHubService

  def initialize(user)
    @token = user.token
    @login = user.login
  end

  def find_repos(search_term)
    response = conn.get(generate_uri(@login, search_term, 'search/repositories'))
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.params['access_token'] = @token
      f.adapter Faraday.default_adapter
    end
  end

  def generate_uri(login, search_term, uri)
    encoded = URI.encode("search/repositories?q=#{search_term}+in:name+user:#{login}+fork:true")
    URI.parse(encoded)
  end

end
