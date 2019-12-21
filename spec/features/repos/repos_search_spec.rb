require 'rails_helper'

describe 'A signed in User can search for their repos' do
  before(:all) do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth
  end

  it 'can search for a list of repos', :vcr do
    user = create(:user, login: 'ap2322', token: ENV['GITHUB_TEST_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/repos'

    fill_in 'search', with: 'monster_shop'
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
    # allow_any_instance_of(Repos::SearchController).to receive(:find_github_repos).and_return(mock_repos_found)
    click_on 'search'

    expect(current_path).to eq('/repos_search')

    within '.found-repos' do
      expect(page).to have_content('monster_shop_1908')
      expect(page).to have_content('monster_shop_final')
    end
  end
end
