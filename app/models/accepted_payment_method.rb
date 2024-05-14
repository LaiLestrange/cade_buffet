class AcceptedPaymentMethod < ApplicationRecord
  belongs_to :invoice
  belongs_to :payment_method
end
