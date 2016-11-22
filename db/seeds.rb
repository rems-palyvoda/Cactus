# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# New database
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

# Create user admin
User.create(first_name: "Ivan",
            last_name:  "Zabuv",
            email:      "izabuv@example.com",
            password:   "foobar", password_confirmation: "foobar",
            media:      "https://www.youtube.com/watch?v=MhkGQAoc7bc",
            avatar:     open("app/assets/images/default_avatar.png"),
            admin:      true)

# Create users
99.times do |n|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "#{last_name}@example.com"
  password = "foobar"
  user = User.create(first_name: first_name, last_name: last_name, email: email,
              password: password, password_confirmation: password,
              avatar: open("app/assets/images/default_avatar.png"))
end

# Microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content,
                  image: open("app/assets/images/default_post_image.jpg")) }
end

# Following relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }