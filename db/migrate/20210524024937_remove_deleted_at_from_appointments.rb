class RemoveDeletedAtFromAppointments < ActiveRecord::Migration[6.0]
  def change
    remove_column :appointments, :deleted_at, :datetime
  end
end
