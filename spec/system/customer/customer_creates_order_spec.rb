require 'rails_helper'

describe "Customer creates an order" do
  it "and needs to be authenticated" do

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

    #act
    visit new_order_path

    #assert
    expect(page).not_to have_content 'Novo Orçamento'
    expect(current_path).to eq new_customer_session_path
  end

  it "from the root_page" do
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
        name: "Evento 1 de #{buffet.brand_name}",
        description: '1 Descrição do evento, propaganda, etc',
        menu: '1 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.first],
        buffet: buffet
      )
      # weekday_price = EventPrice.create!(
      #   min_price: 1000,
      #   extra_guest_fee: 10,
      #   overtime_fee: 11,
      #   weekend_schedule: false,
      #   event_type:event
      # )
      # weekend_price = EventPrice.create!(
      #   min_price: 1500,
      #   extra_guest_fee: 15,
      #   overtime_fee: 16,
      #   weekend_schedule: true,
      #   event_type:event
      # )
      customer = Customer.create!(
        name: 'Fulano Cliente',
        social_security_number: "52383271020",
        email: "cliente1@buffet.com",
        password: "cliente"
      )


    login_as customer, scope: :customer

    #act
    visit root_path
    click_on buffet.brand_name
    click_on 'Pedir um Orçamento'
    click_on event.name

    #assert
    expect(current_path).to eq new_order_path
    expect(page).to have_content 'Novo Orçamento'
    within '#new_order_form' do
      expect(page).to have_field 'Data do Evento'
      expect(page).to have_field 'Quantidade de Convidados'
      expect(page).to have_field 'Descrição do Evento'
      expect(page).to have_field 'Endereço do Evento'
      expect(page).to have_button 'Criar Pedido'
    end
  end

  it "successfully" do
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
    customer = Customer.create!(
      name: 'Fulano Cliente',
      social_security_number: "52383271020",
      email: "cliente1@buffet.com",
      password: "cliente"
    )

    login_as customer, scope: :customer

    visit root_path
    click_on buffet.brand_name
    click_on 'Pedir um Orçamento'
    click_on second_event.name

    within '#new_order_form' do
      fill_in 'Data do Evento', with: 1.day.from_now
      fill_in 'Quantidade de Convidados', with: 15
      fill_in 'Descrição do Evento', with: 'Evento para 15 Convidados'
      fill_in 'Endereço do Evento', with: 'Rua Tal, etc'
      click_on 'Criar Pedido'
    end

    order = Order.last
    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Pedido #{order.code}"
    expect(page).to have_content "Status: Aguardando avaliação do Buffet"
    expect(page).to have_content "Buffet: ABC"
    expect(page).to have_content "Tipo de Evento: Evento 2 de ABC"
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data do Evento: #{formatted_date}"
    expect(page).to have_content "Quantidade de Convidados: 15"
    expect(page).to have_content "Sobre o Evento: Evento para 15 Convidados"
    expect(page).to have_content "Endereço do Evento: Rua Tal, etc"

  end

  it "and leaves wrong or missing information" do
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
    customer = Customer.create!(
      name: 'Fulano Cliente',
      social_security_number: "52383271020",
      email: "cliente1@buffet.com",
      password: "cliente"
    )

    login_as customer, scope: :customer

    visit root_path
    click_on buffet.brand_name
    click_on 'Pedir um Orçamento'
    click_on second_event.name

    within '#new_order_form' do
      fill_in 'Data do Evento', with: 1.day.ago
      fill_in 'Quantidade de Convidados', with: ''
      fill_in 'Descrição do Evento', with: 'Evento para 15 Convidados'
      fill_in 'Endereço do Evento', with: 'Rua Tal, etc'
      click_on 'Criar Pedido'
    end

    # expect(current_path).to eq new_order_path
    expect(page).to have_content "Pedido não cadastrado!"
    expect(page).to have_field "Descrição do Evento", with: 'Evento para 15 Convidados'
  end

end

describe 'Customer adds an address to the event' do
  context 'EventType accepts address input' do
    it 'from the root page' do
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
        name: "Evento 1 de #{buffet.brand_name}",
        description: '1 Descrição do evento, propaganda, etc',
        menu: '1 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.first],
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
      click_on buffet.brand_name
      click_on 'Pedir um Orçamento'
      click_on event.name

      expect(current_path).to eq new_order_path
      expect(page).to have_content 'Novo Orçamento'
      expect(page).to have_field 'Endereço do Evento'

    end
    it 'Customer choses own address' do
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
        name: "Evento 1 de #{buffet.brand_name}",
        description: '1 Descrição do evento, propaganda, etc',
        menu: '1 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.first],
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
      click_on buffet.brand_name
      click_on 'Pedir um Orçamento'
      click_on event.name
      fill_in 'Data do Evento', with: 1.day.from_now
      fill_in 'Quantidade de Convidados', with: 20
      fill_in 'Endereço do Evento', with: 'Novo endereço, etc, etc.'
      click_on 'Criar Pedido'

      order = Order.last
      expect(current_path).to eq order_path(order)
      expect(page).to have_content "Pedido #{order.code}"
      expect(page).to have_content "Endereço do Evento: Novo endereço, etc, etc."

    end
    it 'Customer choses buffet address' do
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
        name: "Evento 1 de #{buffet.brand_name}",
        description: '1 Descrição do evento, propaganda, etc',
        menu: '1 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.first],
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
      click_on buffet.brand_name
      click_on 'Pedir um Orçamento'
      click_on event.name
      fill_in 'Data do Evento', with: 1.day.from_now
      fill_in 'Quantidade de Convidados', with: 20
      fill_in 'Endereço do Evento', with: ''
      click_on 'Criar Pedido'

      order = Order.last
      expect(current_path).to eq order_path(order)
      expect(page).to have_content "Pedido #{order.code}"
      expect(page).to have_content "Endereço do Evento: #{buffet.address}"
    end
  end
  context 'EventType doesnt accept address input' do

    it 'from the root page' do
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
      click_on buffet.brand_name
      click_on 'Pedir um Orçamento'
      click_on event.name

      expect(current_path).to eq new_order_path
      expect(page).to have_content 'Novo Orçamento'
      expect(page).not_to have_field 'Endereço do Evento'

    end
    it 'address of event is the same as buffets address' do

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
        name: "Evento 1 de #{buffet.brand_name}",
        description: '1 Descrição do evento, propaganda, etc',
        menu: '1 Cardápio do evento, tipo de comida etc',
        location: true,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: [event_options.first],
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
      click_on buffet.brand_name
      click_on 'Pedir um Orçamento'
      click_on event.name
      fill_in 'Data do Evento', with: 1.day.from_now
      fill_in 'Quantidade de Convidados', with: 20
      click_on 'Criar Pedido'

      order = Order.last
      expect(current_path).to eq order_path(order)
      expect(page).to have_content "Pedido #{order.code}"
      expect(page).to have_content "Endereço do Evento: #{buffet.address}"


    end
  end
end
