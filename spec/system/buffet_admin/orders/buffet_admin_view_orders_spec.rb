require 'rails_helper'

describe 'BuffetAdmin view Orders' do
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

    first_customer = Customer.create!(
        name: 'Fulano Cliente 1',
        social_security_number: "52383271020",
        email: "cliente1@buffet.com",
        password: "cliente"
      )

    second_customer = Customer.create!(
        name: 'Fulano Cliente 2',
        social_security_number: "65514374513",
        email: "cliente2@buffet.com",
        password: "cliente"
      )

    first_order = Order.create!(
      event_date: 1.day.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá amanhã',
      customer: second_customer,
      buffet: buffet,
      event_type: first_event
    )
    second_order = Order.create!(
      event_date: 1.week.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá daqui uma semana',
      customer: first_customer,
      buffet: buffet,
      event_type: second_event
    )

    login_as admin, scope: :buffet_admin

    visit root_path
    click_on 'Pedidos'

    expect(current_path).to eq orders_path
    expect(page).to have_content 'Pedidos'
    expect(page).to have_content first_order.code
    expect(page).to have_content first_order.event_date
    expect(page).to have_content second_order.code
    expect(page).to have_content second_order.event_date


  end

  it 'and sees them in order by status' do

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

    first_customer = Customer.create!(
        name: 'Fulano Cliente 1',
        social_security_number: "52383271020",
        email: "cliente1@buffet.com",
        password: "cliente"
      )

    second_customer = Customer.create!(
        name: 'Fulano Cliente 2',
        social_security_number: "65514374513",
        email: "cliente2@buffet.com",
        password: "cliente"
      )

    first_order = Order.create!(
      event_date: 1.day.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá amanhã',
      customer: second_customer,
      buffet: buffet,
      event_type: first_event,
    )
    first_order.confirmed!

    second_order = Order.create!(
      event_date: 1.week.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá daqui uma semana',
      customer: first_customer,
      buffet: buffet,
      event_type: second_event
    )
    second_order.canceled!

    third_order = Order.create!(
      event_date: 1.month.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá daqui um mês',
      customer: first_customer,
      buffet: buffet,
      event_type: second_event
    )

    login_as admin, scope: :buffet_admin

    visit root_path
    click_on 'Pedidos'

    expect(current_path).to eq orders_path
    expect(page).to have_content 'Pedidos'


    within ('#orders > div:nth-child(1)') do
      expect(page).to have_content third_order.code
    end
    within ('#orders > div:nth-child(2)') do
      expect(page).to have_content first_order.code
    end
    within ('#orders > div:nth-child(3)') do
      expect(page).to have_content second_order.code
    end

  end

  it 'and view order details' do
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

    first_customer = Customer.create!(
        name: 'Fulano Cliente 1',
        social_security_number: "52383271020",
        email: "cliente1@buffet.com",
        password: "cliente"
      )

    second_customer = Customer.create!(
        name: 'Fulano Cliente 2',
        social_security_number: "65514374513",
        email: "cliente2@buffet.com",
        password: "cliente"
      )

    first_order = Order.create!(
      event_date: 1.day.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá amanhã',
      customer: second_customer,
      buffet: buffet,
      event_type: first_event
    )
    second_order = Order.create!(
      event_date: 1.week.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá daqui uma semana',
      customer: first_customer,
      buffet: buffet,
      event_type: second_event
    )

    login_as admin, scope: :buffet_admin

    visit root_path
    click_on 'Pedidos'
    click_on second_order.code

    expect(current_path).to eq order_path(second_order)
    expect(page).to have_content "Pedido #{second_order.code}"
    expect(page).to have_content second_order.more_details


  end

  it 'and view orders for the same date' do

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
    third_order = Order.create!(
      event_date: 1.week.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que também acontecerá daqui uma semana',
      customer: customer,
      buffet: buffet,
      event_type: second_event
    )

    login_as admin, scope: :buffet_admin

    visit root_path
    click_on 'Pedidos'
    click_on second_order.code

    expect(current_path).to eq order_path(second_order)
    expect(page).to have_content "Pedido #{second_order.code}"
    expect(page).to have_content second_order.more_details
    expect(page).to have_content 'Alerta!'
    expect(page).to have_content 'Outros eventos para o mesmo dia:'
    expect(page).to have_content third_order.code
    expect(page).to have_content third_order.event_date
    expect(page).to have_content third_order.status
  end

  it 'and doesnt view others orders' do
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

    # first_payment_methods = [
    #   PaymentMethod.create!(
    #     name: "Pix #{first_buffet.brand_name}",
    #     details: "Chave: #{first_buffet.email}",
    #     buffet: first_buffet
    #   ),
    #   PaymentMethod.create!(
    #     name: 'Cartão de Crédito',
    #     details: 'Parcela em até 12x com juros de +5%',
    #     buffet: first_buffet
    #   ),
    #   PaymentMethod.create!(
    #     name: 'Dinheiro',
    #     details: 'Desconto de 10%',
    #     buffet: first_buffet
    #   )]

    # second_payment_methods = [
    #   PaymentMethod.create!(
    #     name: "Pix #{second_buffet.brand_name}",
    #     details: "Chave: #{second_buffet.email}",
    #     buffet: second_buffet
    #   ),
    #   PaymentMethod.create!(
    #     name: 'Cartão de Crédito',
    #     details: 'Parcela em até 6x com juros de +2.5%',
    #     buffet: second_buffet
    #   ),
    #   PaymentMethod.create!(
    #     name: 'PayPal',
    #     details: 'Pagamento online via PayPal',
    #     buffet: second_buffet
    #   )]

    first_event = EventType.create!(
      name: "Evento de #{first_buffet.brand_name}",
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: [event_options.first],
      buffet: first_buffet
    )
    # weekday_price_e1b1 = EventPrice.create!(
    #   min_price: 1000,
    #   extra_guest_fee: 10,
    #   overtime_fee: 11,
    #   weekend_schedule: false,
    #   event_type: first_event
    # )

    # weekend_price_e1b1 = EventPrice.create!(
    #   min_price: 1500,
    #   extra_guest_fee: 15,
    #   overtime_fee: 16,
    #   weekend_schedule: true,
    #   event_type: first_event
    # )

    second_event = EventType.create!(
      name: "Evento de #{second_buffet.brand_name}",
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: [event_options.first],
      buffet: second_buffet
    )

    # weekday_price_e1b2 = EventPrice.create!(
    #   min_price: 1000,
    #   extra_guest_fee: 10,
    #   overtime_fee: 11,
    #   weekend_schedule: false,
    #   event_type: second_event
    # )

    # weekend_price_e1b2 = EventPrice.create!(
    #   min_price: 1500,
    #   extra_guest_fee: 15,
    #   overtime_fee: 16,
    #   weekend_schedule: true,
    #   event_type: second_event
    # )

    first_customer = Customer.create!(
      name: 'Fulano Cliente 1',
      social_security_number: "52383271020",
      email: "cliente1@buffet.com",
      password: "cliente"
    )
    second_customer = Customer.create!(
      name: 'Fulano Cliente 2',
      social_security_number: "28290899017",
      email: "cliente2@buffet.com",
      password: "cliente"
    )


    first_order = Order.create!(
      event_date: 1.day.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá amanhã',
      customer: first_customer,
      buffet: first_buffet,
      event_type: first_event
    )
    second_order = Order.create!(
      event_date: 1.week.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá daqui uma semana',
      customer: first_customer,
      buffet: second_buffet,
      event_type: second_event
    )
    third_order = Order.create!(
      event_date: 1.week.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá daqui uma semana',
      customer: second_customer,
      buffet: first_buffet,
      event_type: first_event
    )

    login_as first_admin, scope: :buffet_admin
    visit orders_path

    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code

  end
end
