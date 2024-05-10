class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :relationships, foreign_key: 'following_id', dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  has_many :followers, through: :reverse_of_relationships, source: :following
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+\z/ }, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).*\z/ }

  def follow(user_id)
    relationships.create(follower_id: user_id)
  end

  def unfollow!(user_id)
    relationships.find_by(follower_id: user_id).destroy
  end
end
