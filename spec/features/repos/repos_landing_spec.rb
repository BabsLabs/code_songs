require 'rails_helper'

describe 'After a user signs in with GitHub, they see a repos page' do
  before(:all) do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth
  end
  it 'has a search bar to search for a repo' do
    user = create(:user, login: 'mockuser', token: 'mock_token')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/repos'

    expect(page).to have_css('#search')
    expect(page).to have_button('search')
  end
end
