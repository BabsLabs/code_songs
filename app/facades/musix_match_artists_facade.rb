class MusixMatchArtistsFacade
  attr_reader :artists

  def initialize(search_term)
    @search_term = search_term
    @artists = fetch_artists
  end

  def fetch_artists
    service = MusixMatchService.new
    @artists_data ||= service.find_artists(search_term)
    
    return [] unless @artists_data[:message][:body][:artist_list]
    @artists_data[:message][:body][:artist_list].map do |data| 
      Artist.new(data[:artist])
    end
  end

  def bad_search
    'No artist found, please search again'
  end

  private 
  attr_reader :search_term
end