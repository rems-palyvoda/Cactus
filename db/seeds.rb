# New database
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

# Create user admin
User.create(first_name: "Ivan",
            last_name:  "Zabuv",
            email:      "izabuv@example.com",
            password:   "foobar", password_confirmation: "foobar",
            avatar:     FFaker::Avatar.image,
            admin:      true)

# Create users
99.times do |n|
  first_name = FFaker::Name.first_name
  last_name = FFaker::Name.last_name
  email = "#{last_name}@example.com"
  password = "foobar"
  User.create(first_name: first_name, last_name: last_name, email: email,
              password: password, password_confirmation: password,
              avatar: open("app/assets/images/default_avatar.png"))
end

# Microposts
users = User.order(:created_at).take(6)
50.times do
  content = FFaker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content,
                  media: FFaker::Youtube.url,
                  image: FFaker::Avatar.image) }
end

# Following relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
