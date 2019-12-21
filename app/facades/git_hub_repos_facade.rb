class GitHubReposFacade
  def initialize(login, search_term)
    @login = login
    @search_term = search_term
  end

  def repos
    service = GitHubService.new
    @repos_data ||= service.find_repos(login, search_term)

    @repos_data[:items].map do |info|
      Repo.new(info)
    end
  end

  private
  attr_reader :login, :search_term
end
