class SessionsController < ApplicationController
    def login
        flash[:notice] = nil
    end

    def login_attempt
        authorized_user = User.authenticate(params[:username], params[:login_password])
        if authorized_user
            session[:user_id] = authorized_user.id
            redirect_to action: 'home'
        else
            flash[:notice] = "Invalid Username or Password"
            render 'login'
        end
    end


    def home
    end

    def profile
    end

    def setting
    end

end
