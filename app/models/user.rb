class User < ApplicationRecord
  
  attr_accessor :remember_token
  
  before_save { self.email = email.downcase }
  
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  mount_uploader :avatar, AvatarUploader
 
  has_many :posts, dependent: :destroy
  has_many :active_relationships,   class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy
  has_many :passive_relationships,  class_name: "Relationship",
                                    foreign_key: :followed_id,
                                    dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
            BCrypt::Engine::MIN_COST :
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

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  def gallery
    Post.where("user_id = :user_id and image NOT NULL", user_id: id)
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

end
