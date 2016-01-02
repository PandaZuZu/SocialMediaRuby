class User < ActiveRecord::Base
    
    validates :first_name,
              :last_name,
              :username,
              :presence => true
    
    validates :first_name,
              :last_name,
              :format => { 
                  :multiline => true,
                  :with => /^[A-z ]+$/
                  }
    
    validates :username,
              :format => {
                  :multiline => true,
                  :with => /^[A-z0-9]+$/
                  }
    
    validates :description,
              :length => {
                  :maximum => 5000
                  }
    
    validates :password,
              :length => {
                  :minimum => 8
                  }
    
end
