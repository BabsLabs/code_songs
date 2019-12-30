class Artists::SearchController < BaseController

  def index
    render locals: {
      artists_found: MusixMatchArtistsFacade.new(params[:search])
    }, template: "artists/index"
  end
end