class CreateEventOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :event_options do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
