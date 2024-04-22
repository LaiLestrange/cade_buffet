class CreateEventTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :event_types do |t|
      t.string :name
      t.string :description
      t.string :menu
      t.boolean :location
      t.integer :min_guests
      t.integer :max_guests
      t.integer :duration
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
