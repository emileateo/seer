class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :master, class_name: :User
end
