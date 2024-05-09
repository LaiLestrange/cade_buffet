class PaymentMethod < ApplicationRecord
  belongs_to :buffet
  # belongs_to :invoice, optional: true
  validates :name, presence: true
end
