# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

puts "Cleaning DB"
Recipe.destroy_all
puts"DB cleaned"

n = 4
puts "Creating #{n} fake movies with Faker"
n.times do
  new_recipe = Recipe.create!(
    name: Faker::Food.dish,
    description: Faker::Food.description,
    image_url: Faker::Internet.url,
    # rating: Faker::Number.decimal(l_digits: 1)
    # this rating apparently doesn t work because it doesn t match the validation
    # that s a good sign bcz it means the validation works
    # the msg error is => ActiveRecord::RecordInvalid: Validation failed:
    # Rating is not included in the list (ActiveRecord::RecordInvalid)
    rating: rand(0..5.0)
  )
   puts "Recipe #{new_recipe.id} created"
end

puts "Finished! #{Recipe.count} created"
