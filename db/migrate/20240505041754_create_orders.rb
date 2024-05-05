class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :buffet, null: false, foreign_key: true
      t.references :event_type, null: false, foreign_key: true
      t.date :event_date
      t.integer :guests
      t.string :address
      t.string :more_details
      t.integer :code
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
