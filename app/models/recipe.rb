class Recipe < ApplicationRecord

    belongs_to :users
    has_many :tags
    has_many :reviews
    has_many :tags, through: :recipe_tags

    # Validations
    validates :title, {
        length: { minimum: 5, maximum: 20 },
        presence: true
    }

    validates :description, {
        length: { minimum: 10 },
        presence: true
    }

    validates :ingredients, {
        length: { minimum: 5 },
        presence: true
    }

    validates :image_url, 
    format: { with: /\.(png|jpg|jpeg)\Z/i, message: "Must be a valid image format" },
    presence: true
end
