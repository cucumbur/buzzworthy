# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Jonny Guitaro",
             email: "jguitar@example.com",
             bio: "Rock on New York! Rock on Chicago",
             password:              "foobar",
             password_confirmation: "foobar",
             gender: :male,
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.com"
  bio = Faker::Hipster.sentence(3)
  password = "password"
  User.create!(name:  name,
               email: email,
               bio: bio,
               password:              password,
               password_confirmation: password,
               gender: :lizard,
               activated: true,
               activated_at: Time.zone.now)
end