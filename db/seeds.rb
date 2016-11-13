# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

User.create(first_name: "Ivan", last_name: "Zabuv",
            email: "izabuv@example.com",
            password: "foobar", password_confirmation: "foobar",
            avatar: open("app/assets/images/default_avatar.png"),
            admin: true)

20.times do |n|
  first_name = "Name_#{n}"
  last_name = "Surname_#{n}"
  email = "#{last_name}@example.com"
  password = "foobar"
  user = User.create(first_name: first_name, last_name: last_name, email: email,
              password: password, password_confirmation: password,
              avatar: open("app/assets/images/default_avatar.png"))
  5.times do |n|
    user.posts.create(content: "Lorem ipsum (#{n})*7")
  end
end