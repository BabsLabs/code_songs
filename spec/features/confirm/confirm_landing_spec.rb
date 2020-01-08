require 'rails_helper'

describe "As a user" do
  before(:all) do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth
  end

  describe "after I have selected a repo and an artist" do
    scenario "I am taken to a confirmation page", :vcr do
      user = create(:user, login: 'BabsLabs', token: ENV['GITHUB_TEST_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/repos'

      fill_in 'search', with: 'battleship'
      click_on 'search'

      within '#repo-1' do
        click_on 'Select this Code'
      end

      expect(current_path).to eq('/artists')

      fill_in 'search', with: 'Elvis Presley'
      click_on 'search'

      within '#artist-1' do
        click_on 'Select this Artist'
      end

      expect(current_path).to eq('/confirm')

      within "#found-repo" do
        expect(page).to have_content("battleship")
        expect(page).to have_button("change repo")
      end

      within "#found-artist" do
        expect(page).to have_content("Elvis Presley")
        expect(page).to have_button("change artist")
      end

      expect(page).to have_button("Songify my Code")
    end

    scenario "I can change my repo", :vcr do
      user = create(:user, login: 'BabsLabs', token: ENV['GITHUB_TEST_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      @songify_cart = SongifyCart.new({})
      allow_any_instance_of(ApplicationController).to receive(:songify_cart).and_return(@songify_cart)

      @songify_cart.add_repo('battleship')
      @songify_cart.add_artist('Elvis Presley', '702')

      visit '/confirm'

      within '#found-repo' do
        click_button 'change repo'
      end

      expect(current_path).to eq('/repos')
    end

    scenario "I can change my artist", :vcr do
      user = create(:user, login: 'BabsLabs', token: ENV['GITHUB_TEST_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      @songify_cart = SongifyCart.new({})
      allow_any_instance_of(ApplicationController).to receive(:songify_cart).and_return(@songify_cart)

      @songify_cart.add_repo('battleship')
      @songify_cart.add_artist('Elvis Presley', '702')

      visit '/confirm'

      within '#found-artist' do
        click_button 'change artist'
      end

      expect(current_path).to eq('/artists')
      expect(@songify_cart.repo).to eq('battleship')
    end
  end

end