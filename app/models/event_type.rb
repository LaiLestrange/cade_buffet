class EventType < ApplicationRecord
  has_many :event_details
  has_many :event_options, through: :event_details

  validates :name,
            :description,
            :menu,
            :min_guests,
            :max_guests,
            :duration,
            :event_option_ids,
             presence: true

  validates :location, inclusion: { in: [true, false] }

  validates :min_guests,
            :max_guests,
            :duration,
             numericality: { only_integer: true }

end
