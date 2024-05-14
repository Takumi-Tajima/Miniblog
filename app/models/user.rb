class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'following_id', dependent: :destroy, inverse_of: 'following'
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy, inverse_of: 'followers'
  has_many :followings, through: :active_relationships, source: :follower
  has_many :followers, through: :passive_relationships, source: :following
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/ }, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).*\z/ }

  def follow(user_id)
    active_relationships.create(follower_id: user_id)
  end

  def unfollow!(user_id)
    active_relationships.find_by(follower_id: user_id).destroy!
  end

  def following?(user)
    followings.exists?(user.id)
  end
end
