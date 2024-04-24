class AddEventPriceToEventTypes < ActiveRecord::Migration[7.1]
  def change
    add_reference :event_types, :event_price, foreign_key: true
  end
end
