class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :customer
  belongs_to :event_type
  enum status: {
    waiting: 0,

    approved: 5,

    confirmed: 7,

    canceled: 9
  }
end
