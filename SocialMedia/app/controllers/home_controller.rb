class HomeController < ApplicationController
  def index
      @featured_users = User.all.sample(3)
  end
end
