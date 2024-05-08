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

  before_validation :generate_code

  validates :event_date,
            :guests,
            :code,
            :address,
            presence: true

  validate :event_date_is_future


  private
  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def event_date_is_future
    if self.event_date.present? && self.event_date <= Date.today
      self.errors.add :event_date, "deve ser futura"
    end
  end

end
