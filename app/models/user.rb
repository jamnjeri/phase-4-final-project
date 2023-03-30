class User < ApplicationRecord
    
    has_many :recipes
    has_many :reviews

    # Helper method to encrypt password
    has_secure_password

    # Validations
    validates :name, {
        presence: true
    }

    validates :username, {
        length: { minimum: 5, maximum: 20}
        uniqueness: true
        presence: true
    }

    validates :email, {
        uniqueness: true,
        presence: true,
        format: { with: URI::MailTo::Email_REGEXP } # for valid email format
    }

    validates :password, {
        length: { minimum: 8},
        if: -> {new_record? || !password.nil?}
    }

    validates :gender, {
        presence: true
    }

end
