class Preference < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :category, optional: true
end
