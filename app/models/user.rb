# == Schema Information
#
# Table name: users
#
#  id              :integer(4)      not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean(1)      default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :admin
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  email_regex = /\A[a-z\d._%\-]+@[a-z0-9.-]+\.[a-z]{2,4}\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: email_regex },
  					uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 6}
  validates :password_confirmation, presence: true

  def feed
    microposts
  end

  def following?(other_user)
    self.relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    self.relationships.create(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end 
