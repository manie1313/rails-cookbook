class Recipe < ApplicationRecord
  has_many :bookmarks
  validates :description, presence: true
  validates :name, presence: true, uniqueness: true
  # The rating of a recipe must be a value between 0 and 5
  validates :rating, inclusion: 0..5
end
