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

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end 
