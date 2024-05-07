require 'rails_helper'

describe 'BuffetAdmin approves orders' do
  context 'BuffetAdmin answers an order' do
    it 'from the buffet page' do
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

      first_event = EventType.create!(
        name: "Evento 1 de #{buffet.brand_name}",
        description: 'Descrição do evento 1, propaganda, etc',
        menu: 'Cardápio do evento 1, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: event_options,
        buffet: buffet
      )

      # weekday_price_e1 = EventPrice.create!(
      #   min_price: 1000,
      #   extra_guest_fee: 10,
      #   overtime_fee: 11,
      #   weekend_schedule: false,
      #   event_type: first_event
      # )

      # weekend_price_e1 = EventPrice.create!(
      #   min_price: 1500,
      #   extra_guest_fee: 15,
      #   overtime_fee: 16,
      #   weekend_schedule: true,
      #   event_type: first_event
      # )

      second_event = EventType.create!(
        name: "Evento 2 de #{buffet.brand_name}",
        description: 'Descrição do evento 2, propaganda, etc',
        menu: 'Cardápio do evento 2, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: event_options,
        buffet: buffet
      )

      # weekday_price_e2 = EventPrice.create!(
      #   min_price: 1000,
      #   extra_guest_fee: 10,
      #   overtime_fee: 11,
      #   weekend_schedule: false,
      #   event_type: second_event
      # )

      # weekend_price_e2 = EventPrice.create!(
      #   min_price: 1500,
      #   extra_guest_fee: 15,
      #   overtime_fee: 16,
      #   weekend_schedule: true,
      #   event_type: second_event
      # )

      customer = Customer.create!(
        name: 'Fulano Cliente',
        social_security_number: "52383271020",
        email: "cliente@buffet.com",
        password: "cliente"
      )

      first_order = Order.create!(
        event_date: 1.day.from_now,
        guests: 25,
        address: 'Endereço do Evento',
        more_details: 'Evento que acontecerá amanhã',
        customer: customer,
        buffet: buffet,
        event_type: first_event
      )
      second_order = Order.create!(
        event_date: 1.week.from_now,
        guests: 25,
        address: 'Endereço do Evento',
        more_details: 'Evento que acontecerá daqui uma semana',
        customer: customer,
        buffet: buffet,
        event_type: second_event
      )

      login_as admin, scope: :buffet_admin
      visit root_path
      click_on 'Pedidos'
      click_on first_order.code

      expect(page).to have_link 'Responder Orçamento'
    end
  end
end