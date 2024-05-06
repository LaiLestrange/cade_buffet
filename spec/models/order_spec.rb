require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "#valid?" do
    it 'true when all valid' do

      event_options = [
        EventOption.create!(name: "Bar",
          description: "Serviço de bebida alcóolica durante o evento"),
        EventOption.create!(name: "Decoração",
          description: "Organização e decoração do espaço do evento"),
        EventOption.create!(name: "Valet",
          description: "Serviço de estacionamento durante o evento")
          ]

      admin =  BuffetAdmin.create!(
        name: "Administrador de Buffet",
        email: "admin@buffet.com",
        password: "buffetadmin"
      )
      buffet = Buffet.create!(
        brand_name: 'ABC',
        company_name: 'ABC Buffet de Eventos LTDA',
        registration_number: '19999',
        phone_number: '11 1111-1111',
        email: 'eventos@buffet.com',
        full_address: 'Rua dos Eventos, 1',
        state: 'EV',
        city: 'Eventual',
        zip_code: '33333-333',
        description: 'Esse é um Buffet de Eventos (1)',
        buffet_admin: admin
      )
      # payment_methods = [
      #   PaymentMethod.create!(
      #     name: "Pix #{buffet.brand_name}",
      #     details: "Chave: #{buffet.email}",
      #     buffet: buffet
      #   ),
      #   PaymentMethod.create!(
      #     name: 'Cartão de Crédito',
      #     details: 'Parcela em até 12x com juros de +5%',
      #     buffet: buffet
      #   ),
      #   PaymentMethod.create!(
      #     name: 'Dinheiro',
      #     details: 'Desconto de 10%',
      #     buffet: buffet
      #   )]

      event = EventType.create!(
        name: "Evento de #{buffet.brand_name}",
        description: 'Descrição do evento, propaganda, etc',
        menu: 'Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: event_options,
        buffet: buffet
      )

      # weekday_price = EventPrice.create!(
      #   min_price: 1000,
      #   extra_guest_fee: 10,
      #   overtime_fee: 11,
      #   weekend_schedule: false,
      #   event_type: event
      # )

      # weekend_price = EventPrice.create!(
      #   min_price: 1500,
      #   extra_guest_fee: 15,
      #   overtime_fee: 16,
      #   weekend_schedule: true,
      #   event_type: event
      # )

      customer = Customer.create!(
          name: 'Fulano Cliente',
          social_security_number: "52383271020",
          email: "cliente1@buffet.com",
          password: "cliente"
        )

      order = Order.new(
        event_date: 1.day.from_now,
        guests: 25,
        address: 'Endereço do Evento',
        more_details: 'Evento que acontecerá amanhã',
        customer: customer,
        buffet: buffet,
        event_type: event
      )

      expect(order.valid?).to eq true
    end
    context 'presence' do
      it 'false when missing value of buffet' do

        order = Order.new(buffet: nil)

        order.valid?
        errors = order.errors

        expect(errors.include? :buffet).to eq true
        expect(errors[:buffet]).to include 'é obrigatório(a)'

      end
      it 'false when missing value of customer' do

        order = Order.new(customer: nil)

        order.valid?
        errors = order.errors

        expect(errors.include? :customer).to eq true
        expect(errors[:customer]).to include 'é obrigatório(a)'

      end
      it 'false when missing value of event_type' do

        order = Order.new(event_type: nil)

        order.valid?
        errors = order.errors

        expect(errors.include? :event_type).to eq true
        expect(errors[:event_type]).to include 'é obrigatório(a)'

      end
      it 'false when missing value of event_date' do

        order = Order.new(event_date: nil)

        order.valid?
        errors = order.errors

        expect(errors.include? :event_date).to eq true
        expect(errors[:event_date]).to include 'não pode ficar em branco'


      end
      it 'false when missing value of guests' do

        order = Order.new(guests: '')

        order.valid?
        errors = order.errors

        expect(errors.include? :guests).to eq true
        expect(errors[:guests]).to include 'não pode ficar em branco'


      end
      it 'false when missing value of code' do

        order = Order.new
        order.valid?

        expect(order.code).not_to be_empty
      end
      it 'false when missing value of address' do

        order = Order.new(address: '')

        order.valid?
        errors = order.errors

        expect(errors.include? :address).to eq true
        expect(errors[:address]).to include 'não pode ficar em branco'
      end
      it 'true when missing value of more_details' do

        order = Order.new(more_details: '')

        order.valid?
        errors = order.errors

        expect(errors.include? :more_details).to eq false
      end
    end

    context 'date is future' do
      it 'false when event_date is past' do

        order = Order.new(event_date: 1.day.ago)

        order.valid?
        errors = order.errors

        expect(errors.include? :event_date).to eq true
        expect(errors[:event_date]).to include 'deve ser futura'
      end
      it 'false when event_date is today' do

        order = Order.new(event_date: Date.today)

        order.valid?
        errors = order.errors

        expect(errors.include? :event_date).to eq true
        expect(errors[:event_date]).to include 'deve ser futura'
      end
      it 'true when event_date is after today' do

        order = Order.new(event_date: 1.day.from_now)

        order.valid?
        errors = order.errors

        expect(errors.include? :event_date).to eq false
      end
    end

    context 'code exists' do
      it 'true when new order' do
        event_options = [
          EventOption.create!(name: "Bar",
            description: "Serviço de bebida alcóolica durante o evento"),
          EventOption.create!(name: "Decoração",
            description: "Organização e decoração do espaço do evento"),
          EventOption.create!(name: "Valet",
            description: "Serviço de estacionamento durante o evento")
            ]

        admin =  BuffetAdmin.create!(
          name: "Administrador de Buffet",
          email: "admin@buffet.com",
          password: "buffetadmin"
        )
        buffet = Buffet.create!(
          brand_name: 'ABC',
          company_name: 'ABC Buffet de Eventos LTDA',
          registration_number: '19999',
          phone_number: '11 1111-1111',
          email: 'eventos@buffet.com',
          full_address: 'Rua dos Eventos, 1',
          state: 'EV',
          city: 'Eventual',
          zip_code: '33333-333',
          description: 'Esse é um Buffet de Eventos (1)',
          buffet_admin: admin
        )
        # payment_methods = [
        #   PaymentMethod.create!(
        #     name: "Pix #{buffet.brand_name}",
        #     details: "Chave: #{buffet.email}",
        #     buffet: buffet
        #   ),
        #   PaymentMethod.create!(
        #     name: 'Cartão de Crédito',
        #     details: 'Parcela em até 12x com juros de +5%',
        #     buffet: buffet
        #   ),
        #   PaymentMethod.create!(
        #     name: 'Dinheiro',
        #     details: 'Desconto de 10%',
        #     buffet: buffet
        #   )]

        event = EventType.create!(
          name: "Evento de #{buffet.brand_name}",
          description: 'Descrição do evento, propaganda, etc',
          menu: 'Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: event_options,
          buffet: buffet
        )

        # weekday_price = EventPrice.create!(
        #   min_price: 1000,
        #   extra_guest_fee: 10,
        #   overtime_fee: 11,
        #   weekend_schedule: false,
        #   event_type: event
        # )

        # weekend_price = EventPrice.create!(
        #   min_price: 1500,
        #   extra_guest_fee: 15,
        #   overtime_fee: 16,
        #   weekend_schedule: true,
        #   event_type: event
        # )

        customer = Customer.create!(
          name: 'Fulano Cliente',
          social_security_number: "52383271020",
          email: "cliente1@buffet.com",
          password: "cliente"
        )

        order = Order.new(
          event_date: 1.day.from_now,
          guests: 25,
          address: 'Endereço do Evento',
          more_details: 'Evento que acontecerá amanhã',
          customer: customer,
          buffet: buffet,
          event_type: event
        )

        order.valid?
        errors = order.errors

        expect(errors.include? :code).to eq false

      end

      it 'and it is unique' do
        event_options = [
          EventOption.create!(name: "Bar",
            description: "Serviço de bebida alcóolica durante o evento"),
          EventOption.create!(name: "Decoração",
            description: "Organização e decoração do espaço do evento"),
          EventOption.create!(name: "Valet",
            description: "Serviço de estacionamento durante o evento")
            ]

        admin =  BuffetAdmin.create!(
          name: "Administrador de Buffet",
          email: "admin@buffet.com",
          password: "buffetadmin"
        )
        buffet = Buffet.create!(
          brand_name: 'ABC',
          company_name: 'ABC Buffet de Eventos LTDA',
          registration_number: '19999',
          phone_number: '11 1111-1111',
          email: 'eventos@buffet.com',
          full_address: 'Rua dos Eventos, 1',
          state: 'EV',
          city: 'Eventual',
          zip_code: '33333-333',
          description: 'Esse é um Buffet de Eventos (1)',
          buffet_admin: admin
        )
        # payment_methods = [
        #   PaymentMethod.create!(
        #     name: "Pix #{buffet.brand_name}",
        #     details: "Chave: #{buffet.email}",
        #     buffet: buffet
        #   ),
        #   PaymentMethod.create!(
        #     name: 'Cartão de Crédito',
        #     details: 'Parcela em até 12x com juros de +5%',
        #     buffet: buffet
        #   ),
        #   PaymentMethod.create!(
        #     name: 'Dinheiro',
        #     details: 'Desconto de 10%',
        #     buffet: buffet
        #   )]

        event = EventType.create!(
          name: "Evento de #{buffet.brand_name}",
          description: 'Descrição do evento, propaganda, etc',
          menu: 'Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: event_options,
          buffet: buffet
        )

        # weekday_price = EventPrice.create!(
        #   min_price: 1000,
        #   extra_guest_fee: 10,
        #   overtime_fee: 11,
        #   weekend_schedule: false,
        #   event_type: event
        # )

        # weekend_price = EventPrice.create!(
        #   min_price: 1500,
        #   extra_guest_fee: 15,
        #   overtime_fee: 16,
        #   weekend_schedule: true,
        #   event_type: event
        # )

        customer = Customer.create!(
          name: 'Fulano Cliente',
          social_security_number: "52383271020",
          email: "cliente1@buffet.com",
          password: "cliente"
        )
        first_order = Order.create!(
          event_date: 1.day.from_now,
          guests: 25,
          address: 'Endereço do Evento',
          more_details: 'Evento que acontecerá amanhã',
          customer: customer,
          buffet: buffet,
          event_type: event
        )
        second_order = Order.new(
          event_date: 1.week.from_now,
          guests: 25,
          address: 'Endereço do Evento',
          more_details: 'Evento que acontecerá amanhã',
          customer: customer,
          buffet: buffet,
          event_type: event
        )
        result = second_order.code != first_order.code
        expect(result).to eq true
      end

    end
  end
end
