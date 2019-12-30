require 'rails_helper'

describe 'As a user' do
  before(:all) do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth
  end

  describe 'after I have selected a repo' do
    scenario 'I am taken to an artists search page' do
      user = create(:user, login: 'CoopTang', token: ENV['GITHUB_TEST_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      songify_cart = SongifyCart.new
      allow_any_instance_of(ApplicationController).to receive(:songify_cart).and_return(songify_cart)

      songify_cart.add_repo('battleship')

      visit '/artists'

      expect(page).to have_content('search for an artist')
      expect(page).to have_css('#search')
      expect(page).to have_button('search')
    end
  end
end