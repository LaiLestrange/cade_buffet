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
      customer = Customer.new(name: '')

      customer.valid?
      errors = customer.errors

      expect(errors.include? :name).to eq true
      expect(errors[:name]).to include 'não pode ficar em branco'
    end
    it 'false when missing value of social_security_number' do
      customer = Customer.new(social_security_number: '')

      customer.valid?
      errors = customer.errors

      expect(errors.include? :social_security_number).to eq true
      expect(errors[:social_security_number]).to include 'não pode ficar em branco'
    end
  end
  context "uniqueness" do
    it 'false when social_security_number is already in use' do
      Customer.create!(
        name: 'Nome do Cliente',
        social_security_number: "48527862085",
        email: "cliente1@buffet.com",
        password: "cl13n73"
      )
      customer = Customer.new(social_security_number: '48527862085')

      customer.valid?
      errors = customer.errors

      expect(errors.include? :social_security_number).to eq true
      expect(errors[:social_security_number]).to include 'já está em uso'
    end
  end
  context "validation of social_security_number" do
    it 'false when social_security_number is not valid' do
      customer = Customer.new(social_security_number: "48527862087")

      customer.valid?
      errors = customer.errors

      expect(errors.include? :social_security_number).to eq true
      expect(errors[:social_security_number]).to include 'CPF Inválido!'
    end
  end
end
end
