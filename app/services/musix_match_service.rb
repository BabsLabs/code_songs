class MusixMatchService

  def find_artists(search_term)
    response = conn(search_term).get('artist.search')
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn(search_term)
    Faraday.new(url: 'https://api.musixmatch.com/ws/1.1/') do |f|
      f.params['apikey'] = ENV['MUSIX_MATCH_TOKEN']
      f.params['q_artist'] = search_term
      f.params['page_size'] = 3
      f.adapter Faraday.default_adapter
    end
  end
end