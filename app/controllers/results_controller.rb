class ResultsController < BaseController
  def show
    render locals: {
      songs_found: SongsFacade.new(current_user, songify_cart)
    }
  end
end
