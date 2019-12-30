class MusixMatchArtistsFacade

  def initialize(search_term)
    @search_term = search_term
    @artists = fetch_artists
  end

  def fetch_artists
    service = MusixMatchService.new
    @artists_data ||= service.find_artists(search_term)
    
    # return [] unless @artists_data[]
    # @artists_data[].map { |data| Artist.new(data) }
  end

  private 
  attr_reader :search_term
end