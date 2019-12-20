class Repos::SearchController < BaseController
  def create
    @repos_found = find_github_repos(current_user.login, params[:search])
    render 'repos/index'
  end

  def find_github_repos(user_login, search_term)
    # Make real api call to give back a list of repos
    # mock_repos_found = [
    #   {
    #     repo_name: 'monster_shop_1908',
    #     owner: 'mockuser',
    #     repo_id: 26877629,
    #   },
    #   {
    #     repo_name: 'monster_shop_final',
    #     owner: 'mockuser',
    #     repo_id: 99999988,
    #   },
    # ]
  end
end
