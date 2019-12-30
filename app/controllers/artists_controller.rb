class ArtistsController < BaseController

  def index
    render locals: { artists_found: nil }
  end
end