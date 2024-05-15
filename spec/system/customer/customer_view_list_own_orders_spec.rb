require 'rails_helper'

describe 'Customer views list of own orders' do
  it 'from the root path' do
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

    order = Order.create!(
      event_date: 1.day.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá amanhã',
      customer: customer,
      buffet: buffet,
      event_type: event
    )

    login_as customer, scope: :customer
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq orders_path
    expect(page).to have_content 'Meus Pedidos'
    expect(page).to have_content order.code
    formatted_date = I18n.localize order.event_date
    expect(page).to have_content formatted_date
  end

  it 'and views all their orders' do
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

    login_as customer, scope: :customer
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq orders_path
    expect(page).to have_content 'Meus Pedidos'
    expect(page).to have_content first_order.code
    first_formatted_date = I18n.localize first_order.event_date
    expect(page).to have_content first_formatted_date
    expect(page).to have_content second_order.code
    second_formatted_date = I18n.localize second_order.event_date
    expect(page).to have_content second_formatted_date
  end

  it 'and only views own orders' do
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

    login_as first_customer, scope: :customer
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq orders_path
    expect(page).to have_content 'Meus Pedidos'
    expect(page).not_to have_content first_order.code
    first_formatted_date = I18n.localize first_order.event_date
    expect(page).not_to have_content first_formatted_date
    expect(page).to have_content second_order.code
    second_formatted_date = I18n.localize second_order.event_date
    expect(page).to have_content second_formatted_date
  end

  it 'and view message if there is no order' do
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


    login_as customer, scope: :customer
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq orders_path
    expect(page).to have_content 'Meus Pedidos'
    expect(page).to have_content 'Ainda não fez nenhum pedido!'
  end
end

describe 'Customer view more details of order' do
  it 'from the root path' do
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

    order = Order.create!(
      event_date: 1.day.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá amanhã',
      customer: customer,
      buffet: buffet,
      event_type: event
    )

    login_as customer, scope: :customer
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Pedido #{order.code}"
    expect(page).to have_content order.more_details
    expect(page).not_to have_content "Responder Orçamento"
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

    login_as first_customer, scope: :customer
    visit order_path(first_order)

    expect(current_path).to eq orders_path
    expect(page).to have_content 'Meus Pedidos'
    expect(page).to have_content 'Acesse os seus pedidos'
    expect(page).not_to have_content first_order.code
    expect(page).not_to have_content first_order.event_date
    expect(page).to have_content second_order.code
    formatted_date = I18n.localize second_order.event_date
    expect(page).to have_content formatted_date
  end

end
