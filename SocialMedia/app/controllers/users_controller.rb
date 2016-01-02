class UsersController < ApplicationController
    def index
        @current_user = User.find_by first_name:'test1'
    end
    
    def register
        @new_user = User.new()
    end
    
    def create
        @new_user = User.new(registration_params)
        if @new_user.save
            redirect_to users_path, :flash => { :success => 'registration complete!' }
        else
            @password_field = String.new
            @username_field = String.new
            render users_register_path
        end
    end
    
    private
    def registration_params
        params.require(:user).permit(:first_name, :last_name, :username, :password)
    end

end
