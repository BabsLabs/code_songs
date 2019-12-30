require 'rails_helper'

describe Artist do
  it 'makes an artist with a name and id' do
    artist = Artist.new({artist_id: 8, artist_name: 'Elvis Presley'})

    expect(artist).to be_an(Artist)
    expect(artist.name).to eq('Elvis Presley')
    expect(artist.id).to eq(8)
  end
end