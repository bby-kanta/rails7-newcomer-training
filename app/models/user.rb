class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :retweets, dependent: :destroy

  # フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    
  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # フォローしているユーザーを取得
  has_many :followings, through: :active_relationships, source: :followed

  # フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower
  
  # フォローリクエスト関連
  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: "follower_id", dependent: :destroy
  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: "followed_id", dependent: :destroy

  # 指定したユーザーをフォローする
  def follow(user)
    if user.private?
      sent_follow_requests.create(followed_id: user.id) unless pending_follow_request?(user)
    else
      active_relationships.create(followed_id: user.id)
    end
  end

  # 指定したユーザーのフォローを解除する
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id)&.destroy
    sent_follow_requests.find_by(followed_id: user.id)&.destroy
  end

  # 指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followings.include?(user)
  end
  
  # フォローリクエストを送っているかどうかを判定
  def pending_follow_request?(user)
    sent_follow_requests.exists?(followed_id: user.id)
  end
  
  # フォローリクエストを受けているかどうかを判定
  def has_follow_request_from?(user)
    received_follow_requests.exists?(follower_id: user.id)
  end
  
  # フォローリクエストを承認
  def approve_follow_request(user)
    request = received_follow_requests.find_by(follower_id: user.id)
    return unless request
    
    request.destroy
    user.active_relationships.create(followed_id: id)
  end
  
  # フォローリクエストを拒否
  def reject_follow_request(user)
    received_follow_requests.find_by(follower_id: user.id)&.destroy
  end

end
