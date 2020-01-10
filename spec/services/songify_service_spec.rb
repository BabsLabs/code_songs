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
    user = create(:user, login: 'ap2322', token: ENV['GITHUB_TEST_TOKEN'])
    cart = SongifyCart.new({'repo' => 'battleship', 'artist_name' => 'Ed Sheeran', 'artist_id'=> '38620990'})

    songify_service = SongifyService.new(user, cart)
    songs_collection = songify_service.match_songs

    # ideal output { songs: {title: , link: }, {title: , link: }}
    expect(songs_collection).to be_a Hash
    expect(songs_collection).to have_key :songs

    expect(songs_collection[:songs]).to be_a Array
    expect(songs_collection[:songs].first).to have_key :title
    expect(songs_collection[:songs].first).to have_key :link
  end

  it 'handles json for codesongs_matcher endpoint with no tracks', :vcr do
    user = create(:user, login: 'ap2322', token: ENV['GITHUB_TEST_TOKEN'])
    cart = SongifyCart.new({'repo' => 'battleship', 'artist_name' => 'Invalid', 'artist_id'=> '38020124'})

    songify_service = SongifyService.new(user, cart)
    songs_collection = songify_service.match_songs
    expect(songs_collection).to eq [{:error=>"Artist has no tracks."}]
  end
end
