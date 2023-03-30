class User < ApplicationRecord
    
    has_secure_password
    has_many :recipes
    has_many :reviews

    validates :username, {
        length: { minimum: 5, maximum: 10}
        uniqueness: true
        presence: true
    }

    validates :email, {
        uniqueness: true,
        presence: true
    }

    validates :password, {
        length: { minimum: 5, maximum: 15}
        
    }

end
