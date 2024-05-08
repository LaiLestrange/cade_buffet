class Invoice < ApplicationRecord
  belongs_to :order
  has_many :payment_methods
  # belongs_to :payment_methods
end
