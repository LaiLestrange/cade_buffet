class EventDetail < ApplicationRecord
  belongs_to :event_option
  belongs_to :event_type
end
