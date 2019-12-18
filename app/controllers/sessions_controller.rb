class SessionsController < ApplicationController
  def create
    # create a new user with github information
    # set current_user to this user
    # redirect to '/users/repos'
    redirect_to '/repos'
  end

  def destroy
    
  end
end
