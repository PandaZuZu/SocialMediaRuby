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
        @query_results = params[:query_results]
        @featured_users = User.all.sample(5)
        @gravatars = ['gravatar0.png', 'gravatar1.png', 'gravatar2.png' , 'gravatar3.png', 'gravatar4.png', 'gravatar5.png', 'gravatar6.png']
        check_gravatar(@current_user)
    end
    
    def search
        keyword = params[:query]
        first_name_results = User.where('first_name like ?', '%' + keyword + '%')
        last_name_results = User.where('last_name like ?', '%' + keyword + '%')
        username_results = User.where('username like ?', '%' + keyword + '%')
        
        
        query_results = ""
        
        first_name_results.each do|q|
            if !query_results.include?(q.username) && q.username != params[:current_user]
                query_results << q.username + ","
            end
        end
        
        last_name_results.each do |q|
            if !query_results.include?(q.username) && q.username != params[:current_user]
                query_results << q.username + ","
            end
        end
        
        username_results.each do |q|
            if !query_results.include?(q.username) && q.username != params[:current_user]
                query_results << q.username + ","
            end
        end
        
        flash[:notice] = params[:current_user]
        
        results = query_results.split(/,/)
        
        redirect_to action: 'home', :query_results => results
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
        
        if !@current_user.friends.include?(@viewing_profile)
            @current_user.friends << @viewing_profile
        end
        
        redirect_to :controller => 'sessions', :action => 'profile', :viewing_profile => @viewing_profile.username
    end
    
    def unfollow
        @current_user = User.find_by username: params[:current_user]
        @viewing_profile = User.find_by username: params[:viewing_profile]
        
        @current_user.friends.delete(@viewing_profile)
        

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
