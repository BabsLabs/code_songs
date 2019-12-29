class GitHubReposFacade
  attr_reader :repos

  def initialize(login, search_term)
    @login = login
    @search_term = search_term
    @repos = fetch_repos
  end

  def fetch_repos
    service = GitHubService.new
    @repos_data ||= service.find_repos(login, search_term)

    return [] unless @repos_data[:items]
    @repos_data[:items].map do |info|
      Repo.new(info)
    end
  end

  def bad_search
    "No repo found, please search again"
  end

  private
  attr_reader :login, :search_term
end
