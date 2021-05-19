class AddFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :birthdate, :date
    add_column :users, :birthtime, :time
    add_column :users, :master, :boolean
    add_column :users, :specialty, :string
  end
end
