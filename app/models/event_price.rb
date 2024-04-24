class EventPrice < ApplicationRecord
  belongs_to :event_type

  validates :min_price,
            :extra_guest_fee,
            :overtime_fee,
            :event_type,
             presence: true

  validates :weekend_schedule, inclusion: { in: [true, false] }

  validates :min_price,
            :extra_guest_fee,
            :overtime_fee,
             numericality: true


  validate :base_prices

  private
  def base_prices
    event_price_ids = self.event_type.event_prices.ids unless self.event_type.nil?
    return if event_price_ids.blank?
    first_price = EventPrice.find(event_price_ids.first)
    if event_price_ids.count == 1
      similar_schedule = first_price.weekend_schedule == self.weekend_schedule
      errors.add(:event_price, "precisa ter agendas diferentes!") if similar_schedule
    else
      errors.add(:event_price, " atingiu a quantidade permitida. Para mais, pague o premium!")
    end
  end
end
