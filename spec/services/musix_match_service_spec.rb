require 'rails_helper'

describe MusixMatchService do
  before :each do
    @musix_match_service = MusixMatchService.new
  end

  scenario 'makes an instance of a MusixMatchService' do
    expect(@musix_match_service).to be_a(MusixMatchService)
  end

  scenario 'makes an api call to search artists with a given param', :vcr do
    search_term = 'Elvis'

    artists_found_info = @musix_match_service.find_artists(search_term)

    expect(artists_found_info[:message][:body]).to have_key :artist_list 
    expect(artists_found_info[:message][:body][:artist_list]).to be_a(Array)
    expect(artists_found_info[:message][:body][:artist_list][0][:artist]).to have_key :artist_id 
    expect(artists_found_info[:message][:body][:artist_list][0][:artist]).to have_key :artist_name 
  end
end