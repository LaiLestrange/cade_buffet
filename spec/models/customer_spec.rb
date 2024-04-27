require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '#valid' do
  it 'true when all valid' do
    customer = Customer.new(
        name: 'Nome do Cliente',
        social_security_number: "48527862085",
        email: "cliente@buffet.com",
        password: "cl13n73"
      )
    expect(customer.valid?).to eq true
  end
  context "presence" do
    it 'false when missing value of name' do
      customer = Customer.new(
        name: '',
        social_security_number: "48527862085",
        email: "cliente@buffet.com",
        password: "cl13n73"
      )

      expect(customer.valid?).to eq false
    end
    it 'false when missing value of social_security_number' do
      customer = Customer.new(
        name: 'Nome do Cliente',
        social_security_number: "",
        email: "cliente@buffet.com",
        password: "cl13n73"
      )
      expect(customer.valid?).to eq false
    end
  end
  context "uniqueness" do
    it 'false when social_security_number is already in use' do
      first_customer = Customer.create!(
        name: 'Nome do Cliente',
        social_security_number: "48527862085",
        email: "cliente1@buffet.com",
        password: "cl13n73"
      )
      second_customer = Customer.new(
        name: 'Mesmo Cliente',
        social_security_number: "48527862085",
        email: "cliente2@buffet.com",
        password: "cl13n73"
      )

      expect(second_customer.valid?).to eq false
    end
  end
  context "validation of social_security_number" do
    it 'false when social_security_number is not valid' do
      customer = Customer.new(
        name: 'Nome do Cliente',
        social_security_number: "48527862088",
        email: "cliente@buffet.com",
        password: "cl13n73"
      )
      expect(customer.valid?).to eq false
    end
  end
end
end
