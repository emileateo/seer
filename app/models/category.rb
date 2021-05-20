class Category < ApplicationRecord
  has_many :preferences, dependent: :destroy
  has_many :users, through: :preferences, dependent: :destroy
  has_many :posts, dependent: :destroy
end
