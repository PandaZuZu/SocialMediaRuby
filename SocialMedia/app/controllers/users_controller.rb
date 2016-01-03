class UsersController < ApplicationController
        
    def register
        @new_user = User.new
        @interests = Interest.all.order(:name)
    end
    
    def create        
        @interests = Interest.all.order(:name)
                
        @new_user = User.new(registration_params)
        if @new_user.save
            
            #interests management
            if params[:interest_ids] != nil && params[:interest_ids].any?
                @interests_ids = params[:interest_ids]
                for i in @interests_ids
                    @current_interest = @interests.find_by id: i
                    @new_user.interests << @current_interest
                end
            end
            
            redirect_to home_index_path, :flash => { :success => 'registration complete!' }
        else
            @username_field = String.new
            render users_register_path
        end
    end
    
    private
    def registration_params
        params.require(:user).permit(:first_name, :last_name, :username, :password, :sex, :birth_date, :description, :gravatar)
    end

end
