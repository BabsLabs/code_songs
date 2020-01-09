require 'rails_helper'

describe SongifyService do
  it 'connects to deployed heroku app', :vcr do
    user = create(:user, login: 'ap2322', token: ENV['GITHUB_TEST_TOKEN'])
    cart = SongifyCart.new({'repo' => 'battleship', 'artist_name' => 'Ed Sheeran', 'artist_id'=> '38620990'})

    songify_service = SongifyService.new(user, cart)

    expect(songify_service).to be_a(SongifyService)

    expect(songify_service.home).to eq 'Hello World!'
  end

  it 'can retrieve json from codesongs_matcher endpoint', :vcr do
    WebMock.enable_net_connect!
    VCR.eject_cassette
    VCR.turn_off!(ignore_cassettes: true)
    user = create(:user, login: 'ap2322', token: ENV['GITHUB_TEST_TOKEN'])
    cart = SongifyCart.new({'repo' => 'battleship', 'artist_name' => 'Ed Sheeran', 'artist_id'=> '38620990'})

    songify_service = SongifyService.new(user, cart)

    expect(songify_service.match_songs).to be_a Array
    expect(songify_service.match_songs.first).to be_a Hash
    expect(songify_service.match_songs.first).to have_key :title
    expect(songify_service.match_songs.first).to have_key :link
  end
end
