class Invoice < ApplicationRecord
before_validation :set_final_price
after_create :approve_order
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

  def initialize(params)
    super(params)
    self.order = Order.find(params[:order_id])
    self.base_price = set_base_price(order)
  end

  private

  def set_base_price(order)
    event = order.event_type

    if event.present? && event.event_prices.count == 1
      price = event.event_prices.first
    else
      if order.event_date.on_weekend?
        price = event.event_prices.where(weekend_schedule: true).first
      else
        price = event.event_prices.where(weekend_schedule: false).first
      end
    end

    base_price = price.min_price

    if order.guests > event.max_guests
      extra_guests = order.guests - event.max_guests
      base_price += extra_guests * price.extra_guest_fee
    end

    base_price
  end

  def set_final_price
    final_price = base_price
    if self.discount.present?
      discount_value = final_price * (self.discount / 100)
      final_price -= discount_value
    end

    if self.increase.present?
      increase_value = final_price * (self.increase / 100)
      final_price += increase_value
    end

    self.final_price = final_price
  end

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

  def approve_order
    self.order.approved!
  end

end
