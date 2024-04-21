require 'rails_helper'

RSpec.describe BuffetAdmin, type: :model do
  describe '#valid' do
    it 'true when all valid' do
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
        payment_methods: 'Pix, Dinheiro',
        buffet_admin_id: first_admin.id
      )
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
        payment_methods: 'Pix, Cartão de Crédito, Dinheiro',
        buffet_admin_id: second_admin.id
      )

      expect(second_buffet.valid?).to eq true
    end
    context "uniqueness" do
      it 'false when buffet is already in use' do
        admin = BuffetAdmin.create!(
          name: 'Admin do Buffet',
          email: 'admin@buffet.com',
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
          payment_methods: 'Pix, Dinheiro',
          buffet_admin_id: admin.id
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
          payment_methods: 'Pix, Cartão de Crédito, Dinheiro',
          buffet_admin_id: admin.id
        )

        expect(second_buffet.valid?).to eq false
      end
    end
  end
end
