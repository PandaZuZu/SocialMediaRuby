class User < ActiveRecord::Base
    has_and_belongs_to_many :interests
    
    attr_accessor :password
    
    before_save :encrypt_password
    after_save :clear_password
    
    
    #encrypt the password
    def encrypt_password
        if password.present?
            self.salt = BCrypt::Engine.generate_salt
            self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
        end
    end
    
    def clear_password
        self.password = nil
    end
    
    #login definitions
    def self.authenticate(username = '', login_password = '')
        user = User.find_by username: username
        
        if user && user.match_password(login_password)
            return user
        else
            return false
        end
    end
    
    def match_password(login_password = '')
        encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
    end
    
    
    #some validations
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
    
    validates :username,
              :uniqueness => true,
              :length => {
                  :in => 6..15
                  }
                       
    
    validates :password,
              :confirmation => true,
              :length => {
                  :minimum => 8,
                  :on => :create
                  }
    
    validates_confirmation_of :password
end
