class RemoveLuckyNumberAndColourFromPost < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :lucky_color, :string
    remove_column :posts, :lucky_number, :integer
  end
end
