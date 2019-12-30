class SongifyCartController < BaseController

  def update
    songify_cart.add_repo(params[:repo_name])
    redirect_to '/artists'
  end
end