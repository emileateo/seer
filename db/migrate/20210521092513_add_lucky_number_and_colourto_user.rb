class AddLuckyNumberAndColourtoUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :lucky_color, :string
    add_column :users, :lucky_number, :integer
  end
end
