class ApplicationController < ActionController::Base
  helper_method :current_user, :songify_cart

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def songify_cart
    @songify_cart ||= SongifyCart.new(session[:songify_cart] ||= Hash.new(0))
  end
end
