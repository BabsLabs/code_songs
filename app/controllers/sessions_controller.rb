class SessionsController < ApplicationController
  def create
    user = User.find_or_create_by(user_params)
    if user
      flash[:success] = "You're logged in!"
      session[:user_id] = user.id
      redirect_to '/repos'
    else
      flash[:error] = "Failed to connect to GitHub"
      redirect_to '/'
    end
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
