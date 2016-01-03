class HomeController < ApplicationController
    
    before_filter :save_login_state, :only => [:index]
    
    def index
      @featured_users = User.all.sample(3)
  end
end
