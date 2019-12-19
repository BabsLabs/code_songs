class BaseController < ApplicationController
  before_action :not_signed_in

  def not_signed_in
    render file: '/public/404' unless current_user
  end
end
