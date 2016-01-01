class UsersController < ApplicationController
    def index
        @current_user = User.find_by first_name:'hung'
    end
    
end
