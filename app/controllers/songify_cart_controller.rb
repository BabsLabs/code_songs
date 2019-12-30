class SongifyCartController < BaseController

  def update_repo
    songify_cart.add_repo(params[:repo_name])
    redirect_to '/artists'
  end
  
  def update_artist
    songify_cart.add_artist(params[:artist_name], params[:artist_id])
    redirect_to '/confirm'
  end
end