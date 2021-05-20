class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :master, references: :users, foreign_key: { to_table: :users}
      t.datetime :when
      t.boolean :status
      t.string :message
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
