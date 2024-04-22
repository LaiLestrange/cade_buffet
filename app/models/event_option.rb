class EventOption < ApplicationRecord
  has_many :event_details
  has_many :event_types, through: :event_details

  validates :name,
            :description,
             presence: true
end
