class Post < ApplicationRecord

    has_many :favorites, dependent: :destroy
    belongs_to :user

    def favorited_by?(user)
        favorites.exists?(user_id: user) # user_id: user は user_id: user.id と同じらしい？ user.id にしちゃうとエラーになる（未ログイン状態ではuser.idはnilだから）
    end
end
