# == Schema Information
#
# Table name: microposts
#
#  id         :integer(4)      not null, primary key
#  content    :string(255)
#  user_id    :integer(4)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe "Micropost" do
	let(:user) {User.create(name: 'Name', email: 'email@domain.com', password: 'password', password_confirmation: 'password')}
end
