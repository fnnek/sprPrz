class HomeController < ApplicationController
  def index
    @micropost = current_user.messages.build if logged_in?
  end
end
