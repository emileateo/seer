class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :master, class_name: :User

  validates :message, presence: true
  validates :when, presence: true
end
