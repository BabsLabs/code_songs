require 'rails_helper'

describe 'As a User' do
  before(:all) do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth
  end

  describe "After I choose a song, repo and click 'Songify my Code'" do
    scenario 'it returns me a song for my code', :vcr do

      user = create(:user, login: 'ap2322', token: ENV['GITHUB_TEST_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      @songify_cart = SongifyCart.new({})
      allow_any_instance_of(ApplicationController).to receive(:songify_cart).and_return(@songify_cart)

      @songify_cart.add_repo('battleship')
      @songify_cart.add_artist('Elvis Presley', '702')

      visit '/confirm'

      # mock song hash returned from sinatra
      mock_songs_info = [{title: 'Hound Dog', link: 'mock_link_hd'},
                    {title: "Can't Help Falling in Love", link: 'mock_link_love'},
                    {title: 'Suspicious Minds', link: 'mock_link_minds'},
                    {title: 'Jailhouse Rock', link: 'mock_link_jail'},
                    {title: 'Blue Hawaii', link: 'mock_link_hawaii'}]

      allow_any_instance_of(SongsFacade).to receive(:fetch_matching_songs).and_return(mock_songs_info)

      click_on "Songify my Code"

      expect(current_path).to eq('/results')
      expect(page).to have_content("the song for your repo battleship is Hound Dog by Elvis Presley")
      expect(page).to have_link('play Hound Dog')
    end
  end
end
