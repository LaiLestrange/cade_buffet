class CreateEventDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :event_details do |t|
      t.references :event_option, null: false, foreign_key: true
      t.references :event_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
