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
        @featured_users = User.all.sample(5)
        @gravatars = ['gravatar0.png', 'gravatar1.png', 'gravatar2.png' , 'gravatar3.png', 'gravatar4.png', 'gravatar5.png', 'gravatar6.png']
        check_gravatar(@current_user)
    end
    
    def profile
        @viewing_profile = User.find_by username: params[:viewing_profile]
        
        @gravatars = ['gravatar0.png', 'gravatar1.png', 'gravatar2.png' , 'gravatar3.png', 'gravatar4.png', 'gravatar5.png', 'gravatar6.png']
        @following_status = 'Unfollow'

        if @viewing_profile != nil
            check_gravatar(@viewing_profile)
        end
    end

    def follow
        @current_user = User.find_by username: params[:current_user]
        @viewing_profile = User.find_by username: params[:viewing_profile]
        
       if !@current_user.users.include?(@viewing_profile)
           @current_user.users << @viewing_profile
           flash[:notice] = @current_user.users.all
        end
        
        redirect_to :controller => 'sessions', :action => 'profile', :viewing_profile => @viewing_profile.username
    end
    
    def unfollow
        @current_user = User.find_by username: params[:current_user]
        @viewing_profile = User.find_by username: params[:viewing_profile]
        
        if @current_user.users.include?(@viewwing_profile)
            @current_user.users.delete(@viewing_profile)
            flash[:notice] = 'unfollow'
        end
        
        redirect_to :controller => 'sessions', :action => 'profile', :viewing_profile => @viewing_profile.username
    end
    
    def setting
    end

    def check_gravatar(user_profile = User.new)
        if user_profile.gravatar == nil
            @current_gravatar = @gravatars[0]
        else
            @current_gravatar = @gravatars[user_profile.gravatar]
        end
    end
end
