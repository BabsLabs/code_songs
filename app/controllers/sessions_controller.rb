class SessionsController < ApplicationController
  def create
    user = create_or_update_user
    flash[:success] = "You're logged in!"
    session[:user_id] = user.id
    redirect_to '/repos'
  end

  def destroy
    session.clear
    redirect_to '/'
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

  def create_or_update_user
    user = User.find_by(login: user_params[:login])
    if user
      user.update_attribute(:token, user_params[:token])
    else
      user = User.create(user_params)
    end
    user
  end
end
