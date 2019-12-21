class GitHubService

  def find_repos(login, search_term)
    response = conn.get(generate_uri(login, search_term, 'search/repositories'))
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def generate_uri(login, search_term, uri)
    "search/repositories?q=#{search_term}+in:name+user:#{login}+fork:true"
  end

end
