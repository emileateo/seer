class AddLuckyNumberAndColourtoPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :lucky_color, :string
    add_column :posts, :lucky_number, :integer
  end
end
