class Post < ApplicationRecord

    has_many :favorites, dependent: :destroy
    belongs_to :user

    def favorited_by?(user)
        favorites.exists?(user_id: user)
    end
end
