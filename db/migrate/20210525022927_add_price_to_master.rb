class AddPriceToMaster < ActiveRecord::Migration[6.0]
  def change
    add_monetize :users, :price, currency: { present: false }
  end
end
