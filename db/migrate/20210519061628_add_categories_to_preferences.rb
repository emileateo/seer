class AddCategoriesToPreferences < ActiveRecord::Migration[6.0]
  def change
    add_reference :preferences, :category, null: false, foreign_key: true
  end
end
