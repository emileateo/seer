# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning up database..."
User.destroy_all
Category.destroy_all
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

10.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "123456"
    )

  user.categories << Category.all.sample

  # Post.create!(
  #   category: category
  #   )
puts "User created!"
end
