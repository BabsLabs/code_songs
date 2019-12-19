class SessionsController < ApplicationController
  def create
    # Find user by login => if it exists, make session, if no user found, make new user and log in
    # create a new user with github information
    # user = User.find_by(user_params)
    # binding.pry
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


  private

  def user_params
    {
      login: request.env['omniauth.auth']['extra']['raw_info']['login'],
      token: request.env['omniauth.auth']['credentials']['token']
    }
  end
end
