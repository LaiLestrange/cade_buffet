class Buffet < ApplicationRecord
  belongs_to :buffet_admin

  has_many :orders
  has_many :event_types
  has_many :payment_methods

  # accepts_nested_attributes_for :event_types

  validates :brand_name,
            :company_name,
            :registration_number,
            :phone_number,
            :email,
            :full_address,
            :state,
            :city,
            :zip_code,
            :buffet_admin,
             presence: true
  validates :state, length: { is: 2 }
  validates :registration_number, :buffet_admin, uniqueness: true

  after_validation :set_address


  private
  def set_address
    self.address = "#{full_address}, #{city} (#{state}) - #{zip_code}"
  end
end
