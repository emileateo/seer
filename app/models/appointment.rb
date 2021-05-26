class Appointment < ApplicationRecord
  acts_as_paranoid column: :deleted_at

  belongs_to :user
  belongs_to :master, class_name: :User

  validates :message, presence: true
  validates :when, presence: true
end
