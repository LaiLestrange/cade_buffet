require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe "#valid?" do
    it "true when all valid" do
      first_admin = BuffetAdmin.create!(
        name: 'Admin 1 do Buffet',
        email: 'admin1@buffet.com',
        password: 'buff3t'
      )

      first_buffet = Buffet.create!(
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

      first_payment_methods = [
        PaymentMethod.create!(
          name: 'Pix',
          details: "Chave Pix: 6548745698",
          buffet: first_buffet
        ),
        PaymentMethod.create!(
          name: 'Cartão de Crédito',
          details: "Em até 12x sem Juros",
          buffet: first_buffet
        ),
        PaymentMethod.create!(
          name: 'Cartão de Débito',
          details: "Até 10% de desconto",
          buffet: first_buffet
        )
      ]

      second_admin = BuffetAdmin.create!(
        name: 'Admin 2 do Buffet',
        email: 'admin2@buffet.com',
        password: 'buff3t'
      )

      second_buffet = Buffet.new(
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

      expect(second_buffet.valid?).to eq true
    end
    context "presence" do
      it "false when missing value of brand_name" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.new(
          brand_name: '',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet@buffet.com',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '11222-333',
          description: 'A descrição de um buffet',
          buffet_admin: admin
        )
        expect(buffet.valid?).to eq false
      end
      it "false when missing value of company_name" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: '',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet@buffet.com',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '11222-333',
          description: 'A descrição de um buffet',
          buffet_admin: admin
        )
        expect(buffet.valid?).to eq false
      end
      it "false when missing value of registration_number" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '',
          phone_number: '11 11111-1111',
          email: 'buffet@buffet.com',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '11222-333',
          description: 'A descrição de um buffet',
          buffet_admin: admin
        )
        expect(buffet.valid?).to eq false
      end
      it "false when missing value of phone_number" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '',
          email: 'buffet@buffet.com',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '11222-333',
          description: 'A descrição de um buffet',
          buffet_admin: admin
        )
        expect(buffet.valid?).to eq false
      end
      it "false when missing value of email" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: '',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '11222-333',
          description: 'A descrição de um buffet',
          buffet_admin: admin
        )
        expect(buffet.valid?).to eq false
      end
      it "false when missing value of full_address" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet@buffet.com',
          full_address: '',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '11222-333',
          description: 'A descrição de um buffet',
          buffet_admin: admin
        )
        expect(buffet.valid?).to eq false
      end
      it "false when missing value of state" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet@buffet.com',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: '',
          city: 'Eventuais',
          zip_code: '11222-333',
          description: 'A descrição de um buffet',
          buffet_admin: admin
        )
        expect(buffet.valid?).to eq false
      end
      it "false when missing value of city" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet@buffet.com',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: 'BF',
          city: '',
          zip_code: '11222-333',
          description: 'A descrição de um buffet',
          buffet_admin: admin
        )
        expect(buffet.valid?).to eq false
      end
      it "false when missing value of zip_code" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet@buffet.com',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '',
          description: 'A descrição de um buffet',
          buffet_admin: admin
        )
        expect(buffet.valid?).to eq false
      end
      it "true when missing value of description" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet@buffet.com',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '11222-333',
          description: '',
          buffet_admin: admin
        )
        expect(buffet.valid?).to eq true
      end
      it "false when missing value of buffet_admin" do
        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet@buffet.com',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '11222-333',
          description: 'A descrição de um buffet'
        )
        expect(buffet.valid?).to eq false
      end

      it "true when missing value of payment_methods" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet@buffet.com',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '11222-333',
          description: 'A descrição de um buffet',
          buffet_admin: admin
        )

        expect(buffet.valid?).to eq true
      end
    end
    context "length" do
      it "false when state less than 2 characters" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )

        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet@buffet.com',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: 'B',
          city: 'Eventuais',
          zip_code: '11222-333',
          description: 'A descrição de um buffet',
          buffet_admin: admin
        )

        expect(buffet.valid?).to eq false
      end
      it "false when state more than 2 characters" do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
          password: 'buff3t'
        )

        buffet = Buffet.new(
          brand_name: 'Eventos Buffet',
          company_name: 'Buffet de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '11 11111-1111',
          email: 'buffet@buffet.com',
          full_address: 'Rua dos Buffets, 10, Bairro dos Eventos',
          state: 'BFT',
          city: 'Eventuais',
          zip_code: '11222-333',
          description: 'A descrição de um buffet',
          buffet_admin: admin
        )

        expect(buffet.valid?).to eq false
      end
    end
    context "uniqueness" do
      it 'false when registration_number is already in use' do
        first_admin = BuffetAdmin.create!(
          name: 'Admin 1 do Buffet',
          email: 'admin1@buffet.com',
          password: 'buff3t'
        )
        first_buffet = Buffet.create!(
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

        second_buffet = Buffet.new(
          brand_name: 'Eventos 2 Buffet',
          company_name: 'Buffet 2 de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '22 22222-2222',
          email: 'buffet2@buffet.com',
          full_address: 'Rua dos Buffets, 12, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '22222-222',
          description: 'A descrição do secundo buffet',
          buffet_admin: second_admin
        )

        expect(second_buffet.valid?).to eq false
      end
      it 'false when buffet_admin is already in use' do
        admin = BuffetAdmin.create!(
          name: 'Admin 1 do Buffet',
          email: 'admin1@buffet.com',
          password: 'buff3t'
        )
        first_buffet = Buffet.create!(
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

        second_buffet = Buffet.new(
          brand_name: 'Eventos 2 Buffet',
          company_name: 'Buffet 2 de Eventos LTDA',
          registration_number: '123456789',
          phone_number: '22 22222-2222',
          email: 'buffet2@buffet.com',
          full_address: 'Rua dos Buffets, 12, Bairro dos Eventos',
          state: 'BF',
          city: 'Eventuais',
          zip_code: '22222-222',
          description: 'A descrição do secundo buffet',
          buffet_admin: admin
        )

        expect(second_buffet.valid?).to eq false
      end

    end

  end
end
