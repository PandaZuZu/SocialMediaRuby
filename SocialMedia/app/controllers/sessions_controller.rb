class SessionsController < ApplicationController
    
    before_filter :authenticate_user, :only => [:home, :profile, :setting]
    before_filter :save_login_state, :only => [:login, :login_attempt]
    
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
    
    def logout
        session[:user_id] = nil
        redirect_to(:controller => 'home', :action => 'index')
    end


    def home
        check_gravatar
        
        @random_friends = @current_user.interests
        
    end
    
    def check_gravatar
        if @current_user.gravatar == 1
            @current_gravatar = 'gravatar1.png'
        elsif @current_user.gravatar == 2
            @current_gravatar = 'gravatar2.png'
        elsif @current_user.gravatar == 3
            @current_gravatar = 'gravatar3.png'
        elsif @current_user.gravatar == 4
            @current_gravatar = 'gravatar4.png'
        elsif @current_user.gravatar == 5
            @current_gravatar = 'gravatar5.png'
        elsif @current_user.gravatar == 6
            @current_gravatar = 'gravatar6.png'
        else
            @current_gravatar = 'gravatar0.png'
        end 
    end

    def profile
    end

    def setting
    end

end
