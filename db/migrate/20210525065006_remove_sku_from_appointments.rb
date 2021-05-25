class RemoveSkuFromAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :master_sku, :string
  end
end
