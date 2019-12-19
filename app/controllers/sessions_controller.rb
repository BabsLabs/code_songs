class SessionsController < ApplicationController
  def create
    user = User.find_by(login: user_params[:login])
    user = User.create(user_params) unless user
    flash[:success] = "You're logged in!"
    session[:user_id] = user.id
    redirect_to '/repos'
  end

  def destroy

  end

  def failure
    flash[:error] = "Failed to connect to GitHub"
    redirect_to '/'
  end

  private

  def user_params
    {
      login: request.env['omniauth.auth']['extra']['raw_info']['login'],
      token: request.env['omniauth.auth']['credentials']['token']
    }
  end

  
end
