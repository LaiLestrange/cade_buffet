require 'rails_helper'

describe 'Não são testes!!!!' do
  context 'modelos de arrange' do
    it 'arrange com mutliplos admins, buffets, events, payment e 1 customer' do

      event_options = [
        EventOption.create!(name: "Bar",
          description: "Serviço de bebida alcóolica durante o evento"),
        EventOption.create!(name: "Decoração",
          description: "Organização e decoração do espaço do evento"),
        EventOption.create!(name: "Valet",
          description: "Serviço de estacionamento durante o evento")
                      ]
      first_admin =  BuffetAdmin.create!(
        name: "Administrador 1 de Buffet",
        email: "admin1@buffet.com",
        password: "buffetadmin"
      )

      second_admin =  BuffetAdmin.create!(
        name: "Administrador 2 de Buffet",
        email: "admin2@buffet.com",
        password: "buffetadmin"
      )

      third_admin =  BuffetAdmin.create!(
        name: "Administrador 3 de Buffet",
        email: "admin3@buffet.com",
        password: "buffetadmin"
      )


      first_buffet = Buffet.create!(
        brand_name: '1ABC',
        company_name: '1ABC Buffet de Eventos LTDA',
        registration_number: '19999',
        phone_number: '11 1111-1111',
        email: 'eventos1@buffet.com',
        full_address: 'Rua dos Eventos, 1',
        state: 'EV',
        city: 'Eventual',
        zip_code: '33333-333',
        description: 'Esse é um Buffet de Eventos (1)',
        buffet_admin: first_admin
      )
      second_buffet = Buffet.create!(
        brand_name: '2DEF',
        company_name: '2DEF Buffet de Eventos LTDA',
        registration_number: '29999',
        phone_number: '11 1111-1111',
        email: 'eventos2@buffet.com',
        full_address: 'Rua dos Eventos, 2',
        state: 'EV',
        city: 'Eventual',
        zip_code: '33333-333',
        description: 'Esse é um Buffet de Eventos (2)',
        buffet_admin: second_admin
      )
      third_buffet = Buffet.create!(
        brand_name: '3GHI',
        company_name: '3GHI Buffet de Eventos LTDA',
        registration_number: '39999',
        phone_number: '11 1111-1111',
        email: 'eventos3@buffet.com',
        full_address: 'Rua dos Eventos, 3',
        state: 'EV',
        city: 'Eventual',
        zip_code: '33333-333',
        description: 'Esse é um Buffet de Eventos (3)',
        buffet_admin: third_admin
      )

      first_payment_methods = [
        PaymentMethod.create!(
          name: "Pix #{first_buffet.brand_name}",
          details: "Chave: #{first_buffet.email}",
          buffet: first_buffet
        ),
        PaymentMethod.create!(
          name: 'Cartão de Crédito',
          details: 'Parcela em até 12x com juros de +5%',
          buffet: first_buffet
        ),
        PaymentMethod.create!(
          name: 'Dinheiro',
          details: 'Desconto de 10%',
          buffet: first_buffet
        )]

      second_payment_methods = [
        PaymentMethod.create!(
          name: "Pix #{second_buffet.brand_name}",
          details: "Chave: #{second_buffet.email}",
          buffet: second_buffet
        ),
        PaymentMethod.create!(
          name: 'Cartão de Crédito',
          details: 'Parcela em até 6x com juros de +2.5%',
          buffet: second_buffet
        ),
        PaymentMethod.create!(
          name: 'PayPal',
          details: 'Pagamento online via PayPal',
          buffet: second_buffet
        )]

      third_payment_methods = [
        PaymentMethod.create!(
          name: "Pix #{third_buffet.brand_name}",
          details: "Chave: #{third_buffet.email}",
          buffet: third_buffet
        ),
        PaymentMethod.create!(
          name: 'Cartão de Crédito',
          details: 'Parcela em até 12x sem juros',
          buffet: third_buffet
        )]

      first_event_b1 = EventType.create!(
        name: "Evento 1 de #{first_buffet.brand_name}",
        description: '1 Descrição do evento, propaganda, etc',
        menu: '1 Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.first],
        buffet: first_buffet
      )
      weekday_price_e1b1 = EventPrice.create!(
        min_price: 1000,
        extra_guest_fee: 10,
        overtime_fee: 11,
        weekend_schedule: false,
        event_type: first_event_b1
      )
      weekend_price_e1b1 = EventPrice.create!(
        min_price: 1500,
        extra_guest_fee: 15,
        overtime_fee: 16,
        weekend_schedule: true,
        event_type: first_event_b1
      )

      second_event_b1 = EventType.create!(
        name: "Evento 2 de #{first_buffet.brand_name}",
        description: '2 Descrição do evento, propaganda, etc',
        menu: '2 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: event_options,
        buffet: first_buffet
      )
      weekday_price_e2b1 = EventPrice.create!(
        min_price: 2000,
        extra_guest_fee: 20,
        overtime_fee: 21,
        weekend_schedule: false,
        event_type: second_event_b1
      )
      weekend_price_e2b1 = EventPrice.create!(
        min_price: 2500,
        extra_guest_fee: 20,
        overtime_fee: 26,
        weekend_schedule: true,
        event_type: second_event_b1
      )

      third_event_b1 = EventType.create!(
        name: "Evento 3 de #{first_buffet.brand_name}",
        description: '3 Descrição do evento, propaganda, etc',
        menu: '3 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.last],
        buffet: first_buffet
      )
      weekday_price_e3b1 = EventPrice.create!(
        min_price: 3000,
        extra_guest_fee: 30,
        overtime_fee: 31,
        weekend_schedule: false,
        event_type: third_event_b1
      )
      weekend_price_e3b1 = EventPrice.create!(
        min_price: 3500,
        extra_guest_fee: 30,
        overtime_fee: 36,
        weekend_schedule: true,
        event_type: third_event_b1
      )

      first_event_b2 = EventType.create!(
        name: "Evento 1 de #{second_buffet.brand_name}",
        description: '1 Descrição do evento, propaganda, etc',
        menu: '1 Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.first],
        buffet: second_buffet
      )
      weekday_price_e1b2 = EventPrice.create!(
        min_price: 1000,
        extra_guest_fee: 10,
        overtime_fee: 11,
        weekend_schedule: false,
        event_type: first_event_b2
      )
      weekend_price_e1b2 = EventPrice.create!(
        min_price: 1500,
        extra_guest_fee: 15,
        overtime_fee: 16,
        weekend_schedule: true,
        event_type: first_event_b2
      )

      second_event_b2 = EventType.create!(
        name: "Evento 2 de #{second_buffet.brand_name}",
        description: '2 Descrição do evento, propaganda, etc',
        menu: '2 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: event_options,
        buffet: second_buffet
      )
      weekday_price_e2b2 = EventPrice.create!(
        min_price: 2000,
        extra_guest_fee: 20,
        overtime_fee: 21,
        weekend_schedule: false,
        event_type: second_event_b2
      )
      weekend_price_e2b2 = EventPrice.create!(
        min_price: 2500,
        extra_guest_fee: 20,
        overtime_fee: 26,
        weekend_schedule: true,
        event_type: second_event_b2
      )

      third_event_b2 = EventType.create!(
        name: "Evento 3 de #{second_buffet.brand_name}",
        description: '3 Descrição do evento, propaganda, etc',
        menu: '3 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.last],
        buffet: second_buffet
      )
      weekday_price_e3b2 = EventPrice.create!(
        min_price: 3000,
        extra_guest_fee: 30,
        overtime_fee: 31,
        weekend_schedule: false,
        event_type: third_event_b2
      )
      weekend_price_e3b2 = EventPrice.create!(
        min_price: 3500,
        extra_guest_fee: 30,
        overtime_fee: 36,
        weekend_schedule: true,
        event_type: third_event_b2
      )

      first_event_b3 = EventType.create!(
        name: "Evento 1 de #{third_buffet.brand_name}",
        description: '1 Descrição do evento, propaganda, etc',
        menu: '1 Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.first],
        buffet: third_buffet
      )
      weekday_price_e1b3 = EventPrice.create!(
        min_price: 1000,
        extra_guest_fee: 10,
        overtime_fee: 11,
        weekend_schedule: false,
        event_type: first_event_b3
      )
      weekend_price_e1b3 = EventPrice.create!(
        min_price: 1500,
        extra_guest_fee: 15,
        overtime_fee: 16,
        weekend_schedule: true,
        event_type: first_event_b3
      )

      second_event_b3 = EventType.create!(
        name: "Evento 2 de #{third_buffet.brand_name}",
        description: '2 Descrição do evento, propaganda, etc',
        menu: '2 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: event_options,
        buffet: third_buffet
      )
      weekday_price_e2b3 = EventPrice.create!(
        min_price: 2000,
        extra_guest_fee: 20,
        overtime_fee: 21,
        weekend_schedule: false,
        event_type: second_event_b3
      )
      weekend_price_e2b3 = EventPrice.create!(
        min_price: 2500,
        extra_guest_fee: 20,
        overtime_fee: 26,
        weekend_schedule: true,
        event_type: second_event_b3
      )

      third_event_b3 = EventType.create!(
        name: "Evento 3 de #{third_buffet.brand_name}",
        description: '3 Descrição do evento, propaganda, etc',
        menu: '3 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.last],
        buffet: third_buffet
      )
      weekday_price_e3b3 = EventPrice.create!(
        min_price: 3000,
        extra_guest_fee: 30,
        overtime_fee: 31,
        weekend_schedule: false,
        event_type: third_event_b3
      )
      weekend_price_e3b3 = EventPrice.create!(
        min_price: 3500,
        extra_guest_fee: 30,
        overtime_fee: 36,
        weekend_schedule: true,
        event_type: third_event_b3
      )

      customer = Customer.create!(
        name: 'Fulano Cliente',
        social_security_number: "52383271020",
        email: "cliente1@buffet.com",
        password: "cliente"
      )
    end

    it 'arrange com 1 admin, buffet, e multiplos events e payments' do
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
      payment_methods = [
        PaymentMethod.create!(
          name: "Pix #{buffet.brand_name}",
          details: "Chave: #{buffet.email}",
          buffet: buffet
        ),
        PaymentMethod.create!(
          name: 'Cartão de Crédito',
          details: 'Parcela em até 12x com juros de +5%',
          buffet: buffet
        ),
        PaymentMethod.create!(
          name: 'Dinheiro',
          details: 'Desconto de 10%',
          buffet: buffet
        )]
      first_event = EventType.create!(
        name: "Evento 1 de #{buffet.brand_name}",
        description: '1 Descrição do evento, propaganda, etc',
        menu: '1 Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.first],
        buffet: buffet
      )
      weekday_price_e1 = EventPrice.create!(
        min_price: 1000,
        extra_guest_fee: 10,
        overtime_fee: 11,
        weekend_schedule: false,
        event_type: first_event
      )
      weekend_price_e1 = EventPrice.create!(
        min_price: 1500,
        extra_guest_fee: 15,
        overtime_fee: 16,
        weekend_schedule: true,
        event_type: first_event
      )
      second_event = EventType.create!(
        name: "Evento 2 de #{buffet.brand_name}",
        description: '2 Descrição do evento, propaganda, etc',
        menu: '2 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: event_options,
        buffet: buffet
      )
      weekday_price_e2 = EventPrice.create!(
        min_price: 2000,
        extra_guest_fee: 20,
        overtime_fee: 21,
        weekend_schedule: false,
        event_type: second_event
      )
      weekend_price_e2 = EventPrice.create!(
        min_price: 2500,
        extra_guest_fee: 20,
        overtime_fee: 26,
        weekend_schedule: true,
        event_type: second_event
      )
      third_event = EventType.create!(
        name: "Evento 3 de #{buffet.brand_name}",
        description: '3 Descrição do evento, propaganda, etc',
        menu: '3 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.last],
        buffet: buffet
      )
      weekday_price_e3 = EventPrice.create!(
        min_price: 3000,
        extra_guest_fee: 30,
        overtime_fee: 31,
        weekend_schedule: false,
        event_type: third_event
      )
      weekend_price_e3 = EventPrice.create!(
        min_price: 3500,
        extra_guest_fee: 30,
        overtime_fee: 36,
        weekend_schedule: true,
        event_type: third_event
      )
    end

    it 'arrange com 1 admin, buffet, evento e customer, e payments e prices comentados' do
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
    end

    it 'arrange com 1 admin, buffet, evento e customer, e payments e prices comentados e 1 order' do
      event_options = [
        EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
        EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
        EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento")
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

      order = Order.create!(
        event_date: 1.day.from_now,
        guests: 25,
        address: 'Endereço do Evento',
        more_details: 'Evento que acontecerá amanhã',
        customer: customer,
        buffet: buffet,
        event_type: event
      )
    end
  end
end
