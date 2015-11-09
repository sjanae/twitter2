class User < ActiveRecord::Base
  
  attr_accessor :remember_token
    validates :name, presence: true
    validates :email, presence: true, 
    uniqueness: { case_sensitive: false }
    has_secure_password
  	has_many :tweets
  	acts_as_followable
  	acts_as_follower

  	def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
 
end
