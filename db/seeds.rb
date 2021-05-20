# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

url = 'http://horoscope-api.herokuapp.com/horoscope/today/Libra'
fortune_serialized = URI.open(url).read
fortune = JSON.parse(fortune_serialized)

puts fortune

puts "Cleaning up database..."
User.destroy_all
Category.destroy_all
# Post.destroy_all
puts "Database cleaned"

Category.create!(
  name: "Career"
  )

Category.create!(
  name: "Health"
  )

Category.create!(
  name: "Studies"
  )

Category.create!(
  name: "Relationship"
  )

puts "Category created"

10.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "123456"
    )

  puts "User created!"


  user.categories << Category.all.sample

  Post.create!(
    title: Faker::Quote.yoda,
    description: fortune["horoscope"],
    category: Category.all.sample
    )

  puts "Post created!"

  user = User.create!(
    email: Faker::Internet.email,
    password: "123456",
    master: true,
    specialty: "Love Compatability"
    )

  puts "Master created!"
end
