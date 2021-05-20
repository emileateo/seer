# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'
require 'zodiac'
require 'date'

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
  name: "Finances"
  )

Category.create!(
  name: "Relationship"
  )

puts "Category created"

10.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "123456",
    birthdate: Faker::Date.between_except(from: 10.years.ago, to: 1.year.from_now, excepted: Date.today)
    )

  puts "User created!"

  user_zodiac = user.birthdate.zodiac_sign

  puts user_zodiac

  if user_zodiac == "Aries"
    user_zodiac = "1"
  elsif user_zodiac == "Taurus"
    user_zodiac = "2"
  elsif user_zodiac == "Gemini"
    user_zodiac = "3"
  elsif user_zodiac == "Cancer"
    user_zodiac = "4"
  elsif user_zodiac == "Leo"
    user_zodiac = "5"
  elsif user_zodiac == "Virgo"
    user_zodiac = "6"
  elsif user_zodiac == "Libra"
    user_zodiac = "7"
  elsif user_zodiac == "Scorpio"
    user_zodiac = "8"
  elsif user_zodiac == "Sagittarius"
    user_zodiac = "9"
  elsif user_zodiac == "Capricorn"
    user_zodiac = "10"
  elsif user_zodiac == "Aquarius"
    user_zodiac = "11"
  else user_zodiac = "12"
  end

  puts user_zodiac

  url = "https://api.vedicastroapi.com/json/prediction/dailysun?zodiac=#{user_zodiac}&show_same=true&date=#{Time.now.strftime("%d/%m/%Y")}&type=TYPE&api_key=9ad6241b-9b66-5990-95b1-63654815da21&split=true"

  puts url
  fortune_serialized = URI.open(url).read
  fortune = JSON.parse(fortune_serialized)
  puts fortune

  user.categories << Category.all.sample

  puts Category.all.sample.name

  Post.create!(
    title: Category.all.sample,
    description: fortune["response"]["bot_response"]["relationship"]["split_response"],
    category: Category.all.sample,
    lucky_number: fortune["response"]["lucky_number"][0],
    lucky_color: fortune["response"]["lucky_color"]
    )

  puts "Post created!"

end
