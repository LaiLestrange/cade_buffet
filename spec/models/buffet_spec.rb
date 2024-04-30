require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe "#valid?" do
    it "true when all valid" do
      first_admin = BuffetAdmin.create!(
        name: 'Admin 1 do Buffet',
        email: 'admin1@buffet.com',
        password: 'buff3t'
      )

      Buffet.create!(
        brand_name: 'Eventos 1 Buffet',
        company_name: 'Buffet 1 de Eventos LTDA',
        registration_number: '123456789',
        phone_number: '11 11111-1111',
        email: 'buffet1@buffet.com',
        full_address: 'Rua dos Buffets, 11, Bairro dos Eventos',
        state: 'BF',
        city: 'Eventuais',
        zip_code: '11111-111',
        description: 'A descrição do primeiro buffet',
        buffet_admin: first_admin
      )

      second_admin = BuffetAdmin.create!(
        name: 'Admin 2 do Buffet',
        email: 'admin2@buffet.com',
        password: 'buff3t'
      )

      buffet = Buffet.new(
        brand_name: 'Eventos 2 Buffet',
        company_name: 'Buffet 2 de Eventos LTDA',
        registration_number: '234567891',
        phone_number: '22 22222-2222',
        email: 'buffet2@buffet.com',
        full_address: 'Rua dos Buffets, 12, Bairro dos Eventos',
        state: 'BF',
        city: 'Eventuais',
        zip_code: '22222-222',
        description: 'A descrição do secundo buffet',
        buffet_admin: second_admin
      )

      result = buffet.valid?

      expect(result).to eq true
    end
    context "presence" do
      it "false when missing value of brand_name" do
        buffet = Buffet.new(brand_name: '')
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :brand_name).to eq true
        expect(errors[:brand_name]).to include 'não pode ficar em branco'
      end
      it "false when missing value of company_name" do
        buffet = Buffet.new(company_name: '')
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :company_name).to eq true
        expect(errors[:company_name]).to include 'não pode ficar em branco'
      end
      it "false when missing value of registration_number" do
        buffet = Buffet.new(registration_number: '')
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :registration_number).to eq true
        expect(errors[:registration_number]).to include 'não pode ficar em branco'
      end
      it "false when missing value of phone_number" do
        buffet = Buffet.new(phone_number: '')
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :phone_number).to eq true
        expect(errors[:phone_number]).to include 'não pode ficar em branco'
      end
      it "false when missing value of email" do
        buffet = Buffet.new(email: '')
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :email).to eq true
        expect(errors[:email]).to include 'não pode ficar em branco'
      end
      it "false when missing value of full_address" do
        buffet = Buffet.new(full_address: '')
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :full_address).to eq true
        expect(errors[:full_address]).to include 'não pode ficar em branco'
      end
      it "false when missing value of state" do
        buffet = Buffet.new(state: '')
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :state).to eq true
        expect(errors[:state]).to include 'não pode ficar em branco'
      end
      it "false when missing value of city" do
        buffet = Buffet.new(city: '')
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :city).to eq true
        expect(errors[:city]).to include 'não pode ficar em branco'
      end
      it "false when missing value of zip_code" do
        buffet = Buffet.new(zip_code: '')
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :zip_code).to eq true
        expect(errors[:zip_code]).to include 'não pode ficar em branco'
      end
      it "true when missing value of description" do
        buffet = Buffet.new(description: '')
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :description).to eq false
      end
      it "false when missing value of buffet_admin" do

        buffet = Buffet.new(buffet_admin: nil)
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :buffet_admin).to eq true
        expect(errors[:buffet_admin]).to include 'não pode ficar em branco'
      end
      it "true when missing value of payment_methods" do

        buffet = Buffet.new(payment_methods: [])
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :payment_methods).to eq false
      end
    end
    context "length" do
      it "false when state less than 2 characters" do

        buffet = Buffet.new(state: 'A')
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :state).to eq true
        expect(errors[:state]).to include 'não possui o tamanho esperado (2 caracteres)'
      end
      it "false when state more than 2 characters" do

        buffet = Buffet.new(state: 'ABC')
        buffet.valid?
        errors = buffet.errors

        expect(errors.include? :state).to eq true
        expect(errors[:state]).to include 'não possui o tamanho esperado (2 caracteres)'
      end
    end
    context "uniqueness" do
      it 'false when registration_number is already in use' do
        first_admin = BuffetAdmin.create!(
          name: 'Admin 1 do Buffet',
          email: 'admin1@buffet.com',
          password: 'buff3t'
        )
        Buffet.create!(
          brand_name: 'Eventos 1 Buffet',
          company_name: 'Buffet 1 de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet1@buffet.com',
          full_address: 'Rua dos Buffets, 11, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '11111-111',
          description: 'A descrição do primeiro buffet',
          buffet_admin: first_admin
        )

        second_buffet = Buffet.new(registration_number: '123456789')
        second_buffet.valid?
        errors = second_buffet.errors

        expect(errors.include? :registration_number).to eq true
        expect(errors[:registration_number]).to include 'já está em uso'
      end
      it 'false when buffet_admin is already in use' do
        admin = BuffetAdmin.create!(
          name: 'Admin 1 do Buffet',
          email: 'admin1@buffet.com',
          password: 'buff3t'
        )
        Buffet.create!(
          brand_name: 'Eventos 1 Buffet',
          company_name: 'Buffet 1 de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet1@buffet.com',
          full_address: 'Rua dos Buffets, 11, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '11111-111',
          description: 'A descrição do primeiro buffet',
          buffet_admin: admin
        )

        second_buffet = Buffet.new(buffet_admin: admin)
        second_buffet.valid?
        errors = second_buffet.errors

        expect(errors.include? :buffet_admin).to eq true
        expect(errors[:buffet_admin]).to include 'já está em uso'
      end

    end

  end
end
