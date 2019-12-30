require 'rails_helper'

describe Song do
  it 'initializes with a hash of info' do
    song = Song.new({title: 'Hound Dog', link: 'fake_link'})

    expect(song).to be_a Song
    expect(song.title).to eq('Hound Dog')
    expect(song.link).to eq('fake_link')
  end
end
