# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }

  email_regex = /\A[a-z\d._%\-]+@[a-z0-9.-]+\.[a-z]{2,4}\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: email_regex },
  					uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
end 
