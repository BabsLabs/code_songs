class GitHubReposFacade
  attr_reader :repos

  def initialize(user, search_term)
    @user = user
    @login = user.login
    @search_term = search_term
    @repos = fetch_repos
  end

  def fetch_repos
    service = GitHubService.new(user)
    @repos_data ||= service.find_repos(search_term)

    return [] unless @repos_data[:items]
    @repos_data[:items].map do |info|
      Repo.new(info)
    end
  end

  def bad_search
    "No repo found, please search again"
  end

  private
  attr_reader :login, :search_term, :user
end
