class UsersController < ApplicationController
    def index
        @current_user = User.find_by first_name:'hung'
    end
    
    def register
        @new_user = User.new
    end
    
    def create
        if User.create(registration_params)
            redirect_to users_path, notice => 'User registration complete!'
        else
            redirect_to users_register_path => 'User registration error!'
        end
    end
    
    private
    def registration_params
        params.require(:user).permit(:first_name)
    end

end
