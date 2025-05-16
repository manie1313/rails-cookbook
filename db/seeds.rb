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
require 'open-uri'
require 'json'

puts "Cleaning DB"
Bookmark.destroy_all
Recipe.destroy_all
Category.destroy_all
puts"DB cleaned"

# n = 10
# puts "Creating #{n} fake movies with Faker"
# n.times do
#   new_recipe = Recipe.create!(
#     name: Faker::Food.unique.dish,
#     description: Faker::Food.description,
#     image_url: Faker::Internet.url,
#     # rating: Faker::Number.decimal(l_digits: 1)
#     # this rating apparently doesn t work because it doesn t match the validation
#     # that s a good sign bcz it means the validation works
#     # the msg error is => ActiveRecord::RecordInvalid: Validation failed:
#     # Rating is not included in the list (ActiveRecord::RecordInvalid)
#     rating: rand(0..5.0)
#   )
#    puts "Recipe #{new_recipe.id} created"
# end
# puts "Finished! #{Recipe.count} created"

def recipe_builder(id)
  url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}"
  meal_serialized = URI.parse(url).read
  meal = JSON.parse(meal_serialized)["meals"][0]
  # p meals["strInstructions"]
  # because it s a hash, all the info about meal ==> straight away ==>   p JSON.parse(meal_serialized)["meals"][0]
  #   then we can do p meal["strMeal"]
  #     don t forget rails db:seed each time

  Recipe.create!(
    name: meal["strMeal"],
    description: meal["strInstructions"],
    image_url: meal["strMealThumb"],
    rating: rand(2..5.0).round(1)
  )
end


# categories = ["Vegetarian", "Pasta", "Seafood", "Dessert"]


# categories.each do |category|
#   url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category}"
#   recipe_list = URI.parse(url).read
#   recipes = JSON.parse(recipe_list)
#   recipes["meals"].take(5).each do |recipe|
#     # p recipe["idMeal"]
#     recipe_builder(recipe["idMeal"])
#   end
# end

 puts "#{Recipe.count} recipes created"
