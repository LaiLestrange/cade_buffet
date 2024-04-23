class PaymentMethod < ApplicationRecord
  belongs_to :buffet
  validates :name, presence: true
end
