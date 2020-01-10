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
      mock_songs_info = {songs: [{title: 'Hound Dog', link: 'mock_link_hd'},
                    {title: "Can't Help Falling in Love", link: 'mock_link_love'},
                    {title: 'Suspicious Minds', link: 'mock_link_minds'},
                    {title: 'Jailhouse Rock', link: 'mock_link_jail'},
                    {title: 'Blue Hawaii', link: 'mock_link_hawaii'}]}

      allow_any_instance_of(SongsFacade).to receive(:fetch_matching_songs).and_return(mock_songs_info)

      click_on "Songify my Code"

      expect(current_path).to eq('/results')
      expect(page).to have_content("the song for your repo battleship is Hound Dog by Elvis Presley")
      expect(page).to have_css('#youtube-video')
      expect(page).to have_selector('iframe')

    end
    scenario 'the results page has a button to start over which takes me to the repo search page', :vcr do

      user = create(:user, login: 'ap2322', token: ENV['GITHUB_TEST_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      @songify_cart = SongifyCart.new({})
      allow_any_instance_of(ApplicationController).to receive(:songify_cart).and_return(@songify_cart)

      @songify_cart.add_repo('battleship')
      @songify_cart.add_artist('Elvis Presley', '702')

      visit '/confirm'

      # mock song hash returned from sinatra
      mock_songs_info = {songs: [{title: 'Hound Dog', link: 'mock_link_hd'},
                    {title: "Can't Help Falling in Love", link: 'mock_link_love'},
                    {title: 'Suspicious Minds', link: 'mock_link_minds'},
                    {title: 'Jailhouse Rock', link: 'mock_link_jail'},
                    {title: 'Blue Hawaii', link: 'mock_link_hawaii'}]
                  }

      allow_any_instance_of(SongsFacade).to receive(:fetch_matching_songs).and_return(mock_songs_info)

      click_on "Songify my Code"

      expect(current_path).to eq('/results')

      click_on "Start Over"

      expect(current_path).to eq('/repos')
    end

    scenario 'the results page shows dynamic results', :vcr do
      user = create(:user, login: 'ap2322', token: ENV['GITHUB_TEST_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      @songify_cart = SongifyCart.new({})
      allow_any_instance_of(ApplicationController).to receive(:songify_cart).and_return(@songify_cart)

      @songify_cart.add_repo('battleship')
      @songify_cart.add_artist("Jimmy Buffett", '1131')

      visit '/confirm'

      click_on "Songify my Code"

      expect(current_path).to eq('/results')
      expect(page).to have_content("Cheeseburger in Paradise")
    end

    scenario 'an artist with no tracks sends a flash message and option to pick another artist', :vcr do
      user = create(:user, login: 'ap2322', token: ENV['GITHUB_TEST_TOKEN'])
      cart = SongifyCart.new({'repo' => 'battleship', 'artist_name' => 'Invalid', 'artist_id'=> '38020124'})
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(ApplicationController).to receive(:songify_cart).and_return(cart)

      visit '/confirm'

      click_on "Songify my Code"

      expect(page).to have_content('No tracks found, please select another artist')
      expect(page).to have_button('change artist')
    end
  end
end
