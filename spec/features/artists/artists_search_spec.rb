require 'rails_helper'

describe 'As a user' do
  before(:all) do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth
  end

  before :each do
    @user = create(:user, login: 'CoopTang', token: ENV['GITHUB_TEST_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @songify_cart = SongifyCart.new
    allow_any_instance_of(ApplicationController).to receive(:songify_cart).and_return(@songify_cart)

    @songify_cart.add_repo('battleship')

    visit '/artists'
  end

  it 'can search for a list of artists', :vcr do
    fill_in 'search', with: 'Elvis'
    click_on 'search'

    expect(current_path).to eq('/artists_search')

    within '.found-artists' do
      expect(page).to have_content('Elvis Presley')
      expect(page).to have_content('Elvis Costello')
    end
  end

  it 'shows a button next to the found artists to select that artist', :vcr do
    fill_in 'search', with: 'Elvis'
    click_on 'search'

    within '#artist-1' do
      click_button 'Select this Artist'
    end

    expect(@songify_cart.artist_name).to eq('Elvis Presley')
    expect(@songify_cart.artist_id).to eq('702')

    expect(current_path).to eq('/confirm')
  end
end
    