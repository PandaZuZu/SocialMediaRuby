class HomeController < ApplicationController
  def index
      @featured_users = [User.order("RANDOM()").first,
                         User.order("RANDOM()").first,
                         User.order("RANDOM()").first]
  end
end
