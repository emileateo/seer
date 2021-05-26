class AddStripeToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :master_sku, :string
    add_column :appointments, :checkout_session_id, :string
  end
end
