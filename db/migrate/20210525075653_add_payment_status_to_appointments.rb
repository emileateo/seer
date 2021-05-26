class AddPaymentStatusToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :payment_status, :string
  end
end
