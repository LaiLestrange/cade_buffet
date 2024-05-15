class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :customer
  belongs_to :event_type
  has_one :invoice
  enum status: {
    waiting: 0, #esperando aprovação OK
    approved: 3, #criou o invoice OK
    confirmed: 5, #cliente confirmou NEXT
    canceled: 7, #um dos dois cancelou COULD_BE
    expired: 9, #a data limite expirou COULD_BE
    done: 12 #concluído COULD_BE
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
    self.code = SecureRandom.alphanumeric(8).upcase if self.code.blank?
  end

  def event_date_is_future
    if self.event_date.present? && self.event_date <= Date.today
      self.errors.add :event_date, "deve ser futura"
    end
  end

end
