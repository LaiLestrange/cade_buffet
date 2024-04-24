class CreateEventPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :event_prices do |t|
      t.decimal :min_price
      t.decimal :extra_guest_fee
      t.decimal :overtime_fee
      t.boolean :weekend_schedule
      t.references :event_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
