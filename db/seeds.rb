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
puts "Cleaning up database..."

Category.destroy_all
# Post.destroy_all
puts "Database cleaned"

Category.create!(name: "Career")
Category.create!(name: "Health")
Category.create!(name: "Finances")
Category.create!(name: "Relationship")

puts "Categories created"

5.times do
  rand_zodiac = rand(1..12).to_s

  url = "https://api.vedicastroapi.com/json/prediction/dailysun?zodiac=#{rand_zodiac}&show_same=true&date=#{Time.now.strftime("%d/%m/%Y")}&type=TYPE&api_key=#{ENV["API_KEY"]}&split=true"
  puts url

  fortune_serialized = URI.open(url).read
  fortune = JSON.parse(fortune_serialized)
  pp fortune

  post_category = Category.all.sample

  Post.create!(
    title: post_category.name,
    description: fortune["response"]["bot_response"][post_category.name.downcase]["split_response"],
    category: post_category,
    # lucky_number: fortune["response"]["lucky_number"][0],
    # lucky_color: fortune["response"]["lucky_color"]
  )

  puts "Post created!"
end


case Rails.env

when "development"
  Appointment.destroy_all
  puts "Development appointments deleted"
  User.destroy_all
  puts "Development users deleted"

  5.times do
    rand_zodiac = rand(1..12).to_s
    url = "https://api.vedicastroapi.com/json/prediction/dailysun?zodiac=#{rand_zodiac}&show_same=true&date=#{Time.now.strftime("%d/%m/%Y")}&type=TYPE&api_key=#{ENV["API_KEY"]}&split=true"
    fortune = JSON.parse(URI.open(url).read)
    pp fortune

    User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "123456",
      categories: Category.all.sample(2),
      birthdate: Faker::Date.between_except(from: 10.years.ago, to: 1.year.from_now, excepted: Date.today),
      master: false,
      lucky_number: fortune["response"]["lucky_number"][0],
      lucky_color: fortune["response"]["lucky_color"]
    )

    puts "User created!"

    file = URI.open("https://source.unsplash.com/featured/?face")

    master = User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "123456",
      birthdate: Faker::Date.between_except(from: 10.years.ago, to: 1.year.from_now, excepted: Date.today),
      master: true,
      specialty: Faker::Games::Pokemon.move
    )

    master.photo.attach(io: file, filename: master.name, content_type: 'image/jpg')

    puts "Master created!"
  end
when "production"
  # nothing unique yet
end

# Keeping this zodiac logic cos Aiden spent a lot of time typing it out LOL

  # user_zodiac = user.birthdate.zodiac_sign

  # puts user_zodiac

  # case user_zodiac
  # when "Aries" then user_zodiac = "1"
  # when "Taurus" then user_zodiac = "2"
  # when "Gemini" then user_zodiac = "3"
  # when "Cancer" then user_zodiac = "4"
  # when "Leo" then user_zodiac = "5"
  # when "Virgo" then user_zodiac = "6"
  # when "Libra" then user_zodiac = "7"
  # when "Scorpio" then user_zodiac = "8"
  # when "Sagittarius" then user_zodiac = "9"
  # when "Capricorn" then user_zodiac = "10"
  # when "Aquarius" then user_zodiac = "11"
  # when "Pisces" then user_zodiac = "12"
  # end
