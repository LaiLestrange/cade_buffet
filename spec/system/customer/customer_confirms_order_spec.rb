require 'rails_helper'

describe 'Customer confirms Order' do
  it 'and needs to be authenticated' do
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
      )
    ]

    event = EventType.create!(
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

    weekday_price = EventPrice.create!(
      min_price: 1000,
      extra_guest_fee: 10,
      overtime_fee: 11,
      weekend_schedule: false,
      event_type: event
    )

    weekend_price = EventPrice.create!(
      min_price: 1500,
      extra_guest_fee: 15,
      overtime_fee: 16,
      weekend_schedule: true,
      event_type: event
    )

    customer = Customer.create!(
      name: 'Fulano Cliente',
      social_security_number: "52383271020",
      email: "cliente@buffet.com",
      password: "cliente"
    )

    order = Order.create!(
      event_date: 3.weeks.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá amanhã',
      customer: customer,
      buffet: buffet,
      event_type: event
    )

    invoice = Invoice.create!(
      order_id: order.id,
      expiration_date: 1.week.from_now
    )

    visit order_path(order)

    expect(page).not_to have_content 'Confirmar Orçamento'
    expect(current_path).to eq root_path
    expect(page).to have_content 'Faça login primeiro'

  end

  it 'successfully' do

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
      )
    ]

    event = EventType.create!(
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

    weekday_price = EventPrice.create!(
      min_price: 1000,
      extra_guest_fee: 10,
      overtime_fee: 11,
      weekend_schedule: false,
      event_type: event
    )

    weekend_price = EventPrice.create!(
      min_price: 1500,
      extra_guest_fee: 15,
      overtime_fee: 16,
      weekend_schedule: true,
      event_type: event
    )

    customer = Customer.create!(
      name: 'Fulano Cliente',
      social_security_number: "52383271020",
      email: "cliente@buffet.com",
      password: "cliente"
    )

    order = Order.create!(
      event_date: 3.weeks.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá amanhã',
      customer: customer,
      buffet: buffet,
      event_type: event
    )

    invoice = Invoice.create!(
      order_id: order.id,
      expiration_date: 1.week.from_now
    )

    login_as customer, scope: :customer
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Confirmar Evento'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content 'Evento confirmado com sucesso!'
    expect(page).to have_content 'Proposta de Orçamento'
    expect(page).to have_content "Valor: R$#{invoice.final_price}"
    formatted_date = I18n.localize order.event_date
    expect(page).to have_content "Data do evento: #{formatted_date}"
  end

  #and order is expired
  #and order is already done
  #and tries to cancel order

  #and tries to confirm order of another customer
  #and tries to confirm order that is not approved
  #and tries to confirm order that is expired
  

end
