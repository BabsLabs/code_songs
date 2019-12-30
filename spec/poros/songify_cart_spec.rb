require 'rails_helper'

describe SongifyCart do
  it 'has attributes' do
    cart = SongifyCart.new

    expect(cart).to be_a(SongifyCart)
    expect(cart.repo).to eq(nil)
    expect(cart.artist).to eq(nil)
  end

  it 'can add a repo' do
    cart = SongifyCart.new

    cart.add_repo('battleship')

    expect(cart.repo).to eq('battleship')
  end
  
  it 'can add a artist' do
    cart = SongifyCart.new

    cart.add_artist('Elivis Presley')

    expect(cart.artist).to eq('Elivis Presley')
  end
end