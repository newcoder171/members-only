class User < ApplicationRecord
    attr_accessor :remember_token
    
    before_create :remember
    
    has_secure_password
    has_many :posts


    private
        def remember
            self.remember_token = SecureRandom.urlsafe_base64
            self.remember_digest = Digest::SHA1.hexdigest(remember_token)
            # update_attribute(:remember_digest, Digest::SHA1.hexdigest(remember_token))
        end
end
