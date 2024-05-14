class Invoice < ApplicationRecord
  belongs_to :order
  # has_many :payment_methods

  has_many :accepted_payment_methods
  has_many :payment_methods, through: :accepted_payment_methods

  validates :expiration_date,
            :base_price,
            :final_price,
            presence: true

  validate :deadline
  validate :explanation
  # validate :invoice_value

  private
  def deadline
    if self.expiration_date.present?
      if self.expiration_date >= self.order.event_date
        self.errors.add :expiration_date, "deve ser anterior à data prevista do evento (#{I18n.localize (self.order.event_date)})"
      end
      if self.expiration_date <= Date.today
        self.errors.add :expiration_date, "deve ser futura"
      end
    end
  end
  def explanation
    if self.discount.present? || self.increase.present?
      unless self.description.present?
        self.errors.add :description, "é obrigatória!"
      end
    end
  end


end
