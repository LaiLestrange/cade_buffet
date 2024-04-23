require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  describe "#valid?" do
    it "true when all valid" do
      #Arrange
      admin = BuffetAdmin.create!(
        name: 'Admin 1 do Buffet',
        email: 'admin1@buffet.com',
        password: 'buff3t'
      )
      buffet = Buffet.create!(
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
      payment_method = PaymentMethod.new(
        name: 'Método de Pagamento',
        details: 'Método de Pagamento que o Buffet pode oferecer',
        buffet: buffet
      )

      #Act & Assert
      expect(payment_method.valid?).to eq true

    end
    context "presence" do
      it "false when missing value of name" do
        #Arrange
        admin = BuffetAdmin.create!(
          name: 'Admin 1 do Buffet',
          email: 'admin1@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.create!(
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
        #Arrange
        payment_method = PaymentMethod.new(
          name: '',
          details: 'Método de Pagamento que o Buffet pode oferecer',
          buffet: buffet
        )

        #Act & Assert
        expect(payment_method.valid?).to eq false
      end

      it "true when missing value of details" do
        #Arrange
        admin = BuffetAdmin.create!(
          name: 'Admin 1 do Buffet',
          email: 'admin1@buffet.com',
          password: 'buff3t'
        )
        buffet = Buffet.create!(
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
        payment_method = PaymentMethod.new(
          name: 'Método de Pagamento',
          details: '',
          buffet: buffet
        )

        #Act & Assert
        expect(payment_method.valid?).to eq true
      end

      it "false when missing value of buffet" do
        #Arrange
        payment_method = PaymentMethod.new(
          name: 'Método de Pagamento',
          details: 'Método de Pagamento que o Buffet pode oferecer',
        )

        #Act & Assert
        expect(payment_method.valid?).to eq false
      end
    end
  end
end
