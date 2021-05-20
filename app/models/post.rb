class Post < ApplicationRecord
  belongs_to :category, optional: true
  # has_many :preferences, through: :categories, dependent: :destroy
  # has_many :users, through: :categories, dependent: :destroy
end
