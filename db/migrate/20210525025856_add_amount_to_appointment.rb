class AddAmountToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_monetize :appointments, :amount, currency: { present: false }
  end
end
