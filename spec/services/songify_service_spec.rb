require 'rails_helper'

describe SongifyService do
  it 'connects to deployed heroku app', :vcr do
    user = create(:user, login: 'ap2322', token: ENV['GITHUB_TEST_TOKEN'])
    cart = SongifyCart.new({'repo' => 'battleship', 'artist_name' => 'Ed Sheeran', 'artist_id'=> '38620990'})

    songify_service = SongifyService.new(user, cart)

    expect(songify_service).to be_a(SongifyService)

    expect(songify_service.home).to eq 'Hello World!'
  end
  end
end
