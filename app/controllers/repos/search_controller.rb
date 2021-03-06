class Repos::SearchController < BaseController
  def index
    render locals: {
      repos_found: GitHubReposFacade.new(current_user, params[:search])
    }, template: "repos/index"
  end

end
