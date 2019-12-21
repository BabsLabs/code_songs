require 'rails_helper'

describe GitHubService do
  scenario 'makes an instance of a GitHubService' do
    github_service = GitHubService.new
    expect(github_service).to be_a(GitHubService)
  end

  scenario 'makes an api call to search repositiorties with given params', :vcr do
    user = create(:user, login: 'ap2322')
    search_term = 'monster_shop'
    github_service = GitHubService.new
    repos_found_info = github_service.find_repos(user.login, search_term)

    expect(repos_found_info).to have_key :items
    expect(repos_found_info[:items]).to be_a(Array)
    expect(repos_found_info[:items][0]).to have_key :name
  end
end
