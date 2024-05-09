# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

  #region opções que os eventos podem oferecer
    EventOption.create!(
      name: "O1SEED Bar",
      description: "O1SEED Serviço de bebida alcóolica durante o evento"
    )
    EventOption.create!(
      name: "O2SEED Decoração",
      description: "O2SEED Organização e decoração do espaço do evento"
    )
    EventOption.create!(
      name: "O3SEED Valet",
      description: "O3SEED Serviço de estacionamento durante o evento"
    )
  #endregion

  #region admins de buffets
    seed_admin_1 =  BuffetAdmin.create!(
      name: "A1SEEDAdministrador de Buffet",
      email: "admin1@buffet.com.seed",
      password: "buffetadmin"
    )
    seed_admin_2 =  BuffetAdmin.create!(
      name: "A2SEEDAdministrador de Buffet",
      email: "admin2@buffet.com.seed",
      password: "buffetadmin"
    )
    seed_admin_3 =  BuffetAdmin.create!(
      name: "A3SEEDAdministrador de Buffet",
      email: "admin3@buffet.com.seed",
      password: "buffetadmin"
    )
  #endregion

  #region buffets
    seed_buffet_1 = Buffet.create!(
      brand_name: 'B1A1SEED Eventos Buffet',
      company_name: 'B1A1SEED Buffet de Eventos LTDA',
      registration_number: '19999',
      phone_number: '11 1111-1111',
      email: 'eventos1@buffet.com.seed',
      full_address: 'Rua dos Eventos, 1',
      state: 'EV',
      city: 'Eventual',
      zip_code: '33333-333',
      description: 'Esse é um Buffet de Eventos',
      buffet_admin: seed_admin_1
    )
    seed_buffet_2 = Buffet.create!(
      brand_name: 'B2A2SEED Eventos Buffet',
      company_name: 'B2A2SEED Buffet de Eventos LTDA',
      registration_number: '29999',
      phone_number: '11 1111-1111',
      email: 'eventos2@buffet.com.seed',
      full_address: 'Rua dos Eventos, 2',
      state: 'EV',
      city: 'Eventual',
      zip_code: '33333-333',
      description: 'Esse é um Buffet de Eventos',
      buffet_admin: seed_admin_2
    )
    seed_buffet_3 = Buffet.create!(
      brand_name: 'B3A3SEED Eventos Buffet',
      company_name: 'B3A3SEED Buffet de Eventos LTDA',
      registration_number: '39999',
      phone_number: '11 1111-1111',
      email: 'eventos3@buffet.com.seed',
      full_address: 'Rua dos Eventos, 3',
      state: 'EV',
      city: 'Eventual',
      zip_code: '33333-333',
      description: 'Esse é um Buffet de Eventos',
      buffet_admin: seed_admin_3
    )
  #endregion

  #region payment methods per buffet

    #region buffet 1
      seed_payment_method_b1_1 = PaymentMethod.create!(
        name: 'P1B1SEED Método de Pagamento',
        details: 'P1B1SEED Método de Pagamento que o Buffet pode oferecer',
        buffet: seed_buffet_1
      )
      seed_payment_method_b1_2 = PaymentMethod.create!(
        name: 'P2B1SEED Método de Pagamento',
        details: 'P2B1SEED Método de Pagamento que o Buffet pode oferecer',
        buffet: seed_buffet_1
      )
      seed_payment_method_b1_3 = PaymentMethod.create!(
        name: 'P3B1SEED Método de Pagamento',
        details: 'P3B1SEED Método de Pagamento que o Buffet pode oferecer',
        buffet: seed_buffet_1
      )
    #endregion

    #region buffet 2
      seed_payment_method_b2_1 = PaymentMethod.create!(
        name: 'P1B2SEED Método de Pagamento',
        details: 'P1B2SEED Método de Pagamento que o Buffet pode oferecer',
        buffet: seed_buffet_2
      )
      seed_payment_method_b2_2 = PaymentMethod.create!(
        name: 'P2B2SEED Método de Pagamento',
        details: 'P2B2SEED Método de Pagamento que o Buffet pode oferecer',
        buffet: seed_buffet_2
      )
      seed_payment_method_b2_3 = PaymentMethod.create!(
        name: 'P3B2SEED Método de Pagamento',
        details: 'P3B2SEED Método de Pagamento que o Buffet pode oferecer',
        buffet: seed_buffet_2
      )
    #endregion

    #region buffet 3
      seed_payment_method_b3_1 = PaymentMethod.create!(
        name: 'P1B3SEED Método de Pagamento',
        details: 'P1B3SEED Método de Pagamento que o Buffet pode oferecer',
        buffet: seed_buffet_3
      )
      seed_payment_method_b3_2 = PaymentMethod.create!(
        name: 'P2B3SEED Método de Pagamento',
        details: 'P2B3SEED Método de Pagamento que o Buffet pode oferecer',
        buffet: seed_buffet_3
      )
      seed_payment_method_b3_3 = PaymentMethod.create!(
        name: 'P3B3SEED Método de Pagamento',
        details: 'P3B3SEED Método de Pagamento que o Buffet pode oferecer',
        buffet: seed_buffet_3
      )
      #endregion

  #endregion

  #region events per buffet

    #region buffet 1

      #region event 1
        seed_event_b1_1 = EventType.create!(
          name: 'E1B1SEED Tipo de Evento',
          description: 'E1B1SEED Descrição do evento, propaganda, etc',
          menu: 'E1B1SEED Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: EventOption.all,
          buffet: seed_buffet_1
        )
        seed_e1_weekday_price = EventPrice.create!(
          min_price: 1000,
          extra_guest_fee: 10,
          overtime_fee: 11,
          weekend_schedule: false,
          event_type: seed_event_b1_1
        )
        seed_e1_weekend_price = EventPrice.create!(
          min_price: 1500,
          extra_guest_fee: 15,
          overtime_fee: 16,
          weekend_schedule: true,
          event_type: seed_event_b1_1
        )
      #endregion

      #region event 2
        seed_event_b1_2 = EventType.create!(
          name: 'E2B1SEED Tipo de Evento',
          description: 'E2B1SEED Descrição do evento, propaganda, etc',
          menu: 'E2B1SEED Cardápio do evento, tipo de comida etc',
          location: true,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: EventOption.all,
          buffet: seed_buffet_1
        )
        seed_e2_weekday_price = EventPrice.create!(
          min_price: 2000,
          extra_guest_fee: 20,
          overtime_fee: 21,
          weekend_schedule: false,
          event_type: seed_event_b1_2
        )
        seed_e2_weekend_price = EventPrice.create!(
          min_price: 2500,
          extra_guest_fee: 20,
          overtime_fee: 26,
          weekend_schedule: true,
          event_type: seed_event_b1_2
        )
      #endregion

      #region event 3
        seed_event_b1_3 = EventType.create!(
          name: 'E3B1SEED Tipo de Evento',
          description: 'E3B1SEED Descrição do evento, propaganda, etc',
          menu: 'E3B1SEED Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: EventOption.all,
          buffet: seed_buffet_1
        )
        seed_e2_weekday_price = EventPrice.create!(
          min_price: 3000,
          extra_guest_fee: 30,
          overtime_fee: 31,
          weekend_schedule: false,
          event_type: seed_event_b1_3
        )
        seed_e2_weekend_price = EventPrice.create!(
          min_price: 3500,
          extra_guest_fee: 30,
          overtime_fee: 36,
          weekend_schedule: true,
          event_type: seed_event_b1_3
        )
      #endregion

    #endregion

    #region buffet 2

      #region event 1
        seed_event_b2_1 = EventType.create!(
          name: 'E1B2SEED Tipo de Evento',
          description: 'E1B2SEED Descrição do evento, propaganda, etc',
          menu: 'E1B2SEED Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: EventOption.all,
          buffet: seed_buffet_2
        )
        seed_e1_weekday_price = EventPrice.create!(
          min_price: 1000,
          extra_guest_fee: 10,
          overtime_fee: 11,
          weekend_schedule: false,
          event_type: seed_event_b2_1
        )
        seed_e1_weekend_price = EventPrice.create!(
          min_price: 1500,
          extra_guest_fee: 15,
          overtime_fee: 16,
          weekend_schedule: true,
          event_type: seed_event_b2_1
        )
      #endregion

      #region event 2
        seed_event_b2_2 = EventType.create!(
          name: 'E2B2SEED Tipo de Evento',
          description: 'E2B2SEED Descrição do evento, propaganda, etc',
          menu: 'E2B2SEED Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: EventOption.all,
          buffet: seed_buffet_2
        )
        seed_e2_weekday_price = EventPrice.create!(
          min_price: 2000,
          extra_guest_fee: 20,
          overtime_fee: 21,
          weekend_schedule: false,
          event_type: seed_event_b2_2
        )
        seed_e2_weekend_price = EventPrice.create!(
          min_price: 2500,
          extra_guest_fee: 20,
          overtime_fee: 26,
          weekend_schedule: true,
          event_type: seed_event_b2_2
        )
      #endregion

      #region event 3
        seed_event_b2_3 = EventType.create!(
          name: 'E3B2SEED Tipo de Evento',
          description: 'E3B2SEED Descrição do evento, propaganda, etc',
          menu: 'E3B2SEED Cardápio do evento, tipo de comida etc',
          location: true,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: EventOption.all,
          buffet: seed_buffet_2
        )
        seed_e2_weekday_price = EventPrice.create!(
          min_price: 3000,
          extra_guest_fee: 30,
          overtime_fee: 31,
          weekend_schedule: false,
          event_type: seed_event_b2_3
        )
        seed_e2_weekend_price = EventPrice.create!(
          min_price: 3500,
          extra_guest_fee: 30,
          overtime_fee: 36,
          weekend_schedule: true,
          event_type: seed_event_b2_3
        )
      #endregion

    #endregion

    #region buffet 3

      #region event 1
        seed_event_b3_1 = EventType.create!(
          name: 'E1B3SEED Tipo de Evento',
          description: 'E1B3SEED Descrição do evento, propaganda, etc',
          menu: 'E1B3SEED Cardápio do evento, tipo de comida etc',
          location: true,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: EventOption.all,
          buffet: seed_buffet_3
        )
        seed_e1_weekday_price = EventPrice.create!(
          min_price: 1000,
          extra_guest_fee: 10,
          overtime_fee: 11,
          weekend_schedule: false,
          event_type: seed_event_b3_1
        )
        seed_e1_weekend_price = EventPrice.create!(
          min_price: 1500,
          extra_guest_fee: 15,
          overtime_fee: 16,
          weekend_schedule: true,
          event_type: seed_event_b3_1
        )
      #endregion

      #region event 2
        seed_event_b3_2 = EventType.create!(
          name: 'E2B3SEED Tipo de Evento',
          description: 'E2B3SEED Descrição do evento, propaganda, etc',
          menu: 'E2B3SEED Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: EventOption.all,
          buffet: seed_buffet_3
        )
        seed_e2_weekday_price = EventPrice.create!(
          min_price: 2000,
          extra_guest_fee: 20,
          overtime_fee: 21,
          weekend_schedule: false,
          event_type: seed_event_b3_2
        )
        seed_e2_weekend_price = EventPrice.create!(
          min_price: 2500,
          extra_guest_fee: 20,
          overtime_fee: 26,
          weekend_schedule: true,
          event_type: seed_event_b3_2
        )
      #endregion

      #region event 3
        seed_event_b3_3 = EventType.create!(
          name: 'E3B3SEED Tipo de Evento',
          description: 'E3B3SEED Descrição do evento, propaganda, etc',
          menu: 'E3B3SEED Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: EventOption.all,
          buffet: seed_buffet_3
        )
        seed_e2_weekday_price = EventPrice.create!(
          min_price: 3000,
          extra_guest_fee: 30,
          overtime_fee: 31,
          weekend_schedule: false,
          event_type: seed_event_b3_3
        )
        seed_e2_weekend_price = EventPrice.create!(
          min_price: 3500,
          extra_guest_fee: 30,
          overtime_fee: 36,
          weekend_schedule: true,
          event_type: seed_event_b3_3
        )
      #endregion

    #endregion

  #endregion

  #region customers
    seed_customer_1 = Customer.create!(
      name: 'C1SEED Nome do Cliente 1',
      social_security_number: "54571916051",
      email: "cliente1@buffet.com.seed",
      password: "cliente"
    )
    seed_customer_2 = Customer.create!(
      name: 'C2SEED Nome do Cliente 2',
      social_security_number: "58248282023",
      email: "cliente2@buffet.com.seed",
      password: "cliente"
    )
    seed_customer_3 = Customer.create!(
      name: 'C3SEED Nome do Cliente 3',
      social_security_number: "67430469060",
      email: "cliente3@buffet.com.seed",
      password: "cliente"
    )
  #endregion


  #region orders
    seed_order_1 = Order.create!(
      event_date: 10.days.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá em 10 dias',
      customer: seed_customer_1,
      buffet: seed_buffet_1,
      event_type: seed_event_b1_1
    )
    seed_order_2 = Order.create!(
      event_date: 10.weeks.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá em 10 semanas',
      customer: seed_customer_1,
      buffet: seed_buffet_2,
      event_type: seed_event_b2_3
    )
    seed_order_3 = Order.create!(
      event_date: 1.month.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá daqui 1 mês',
      customer: seed_customer_2,
      buffet: seed_buffet_3,
      event_type: seed_event_b3_1
    )
    seed_order_4 = Order.create!(
      event_date: 1.month.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que também acontecerá daqui 1 mês',
      customer: seed_customer_2,
      buffet: seed_buffet_2,
      event_type: seed_event_b2_1
    )
    seed_order_5 = Order.create!(
      event_date: 1.year.from_now,
      guests: 80,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá ano que vem',
      customer: seed_customer_3,
      buffet: seed_buffet_1,
      event_type: seed_event_b1_3
    )
    seed_order_6 = Order.create!(
      event_date: 2.months.from_now,
      guests: 25,
      address: 'Endereço do Evento',
      more_details: 'Evento que acontecerá daqui dois meses',
      customer: seed_customer_3,
      buffet: seed_buffet_1,
      event_type: seed_event_b1_3
    )
  #endregion
