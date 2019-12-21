class ReposController < BaseController
  def index
    render locals: { repos_found: nil}
  end
end
