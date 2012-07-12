namespace :db do
  desc "Fill database with sample users"

  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end

  def make_users
    admin = User.create!(name: "Example User", email: "example@rails.com",
                         password: "password", password_confirmation: "password")
    admin.toggle!(:admin)

    40.times do |n|
      name = Faker::Name.name
      email = "example_#{n+1}@rails.com"
      password = "password"
      User.create!(name: name, email: email,
                   password: password, password_confirmation: password)
    end
  end

  def make_microposts
    users = User.all(limit: 5)
    40.times do |n|
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end

  def make_relationships
    users = User.all
    user = users.first
    followed_users = users[2..10]
    followers = users[5..20]

    followed_users.each { |followed_user| user.follow!(followed_user) }
    followers.each { |follower| follower.follow!(user) }
  end
end