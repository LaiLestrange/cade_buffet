class PaymentMethod < ApplicationRecord
  belongs_to :buffet
  # belongs_to :invoice, optional: true
  has_many :accepted_payment_methods
  has_many :invoices, through: :accepted_payment_methods
  validates :name, presence: true
end
