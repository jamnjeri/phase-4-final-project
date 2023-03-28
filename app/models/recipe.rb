class Recipe < ApplicationRecord
    belogs_to :users

    validates :title, {
        length: { minimum: 5, maximum: 20 },
        presence: true
    }

    validates :description, {
        length: { minimum: 20 },
        presence: true
    }

    validates :ingredients, {
        length: { minimum: 5 },
        presence: true
    }
end
