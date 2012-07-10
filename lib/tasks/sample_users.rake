namespace :db do
  desc "Fill database with sample users"

  task populate: :environment do
  	admin = User.create!(name: "Example User", email: "example@rails.com",
  				 password: "password", password_confirmation: "password")
    admin.toggle!(:admin)
    
  	99.times do |n|
  		name = Faker::Name.name
  		email = "example_#{n+1}@rails.com"
  		password = "password"
  		User.create!(name: name, email: email,
  					 password: password, password_confirmation: password)
  	end

    users = User.all(limit: 5)
    50.times do |n|
      content = Faker::Lorem.sentence(5)
      users.each { |user|  user.microposts.create!(content: content)}
    end
  end
end