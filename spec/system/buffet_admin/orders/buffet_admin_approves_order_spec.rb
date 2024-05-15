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
      click_on 'Responder Orçamento'

      expect(current_path).to eq new_order_invoice_path(first_order)
      expect(page).to have_content 'Proposta de Orçamento'
      within ('#order_details') do
        expect(page).to have_content first_order.code
        first_formatted_date = I18n.localize first_order.event_date
        expect(page).to have_content first_formatted_date
        expect(page).to have_content first_order.guests
        expect(page).to have_content first_order.address
        expect(page).to have_content first_order.more_details
        expect(page).to have_content first_order.customer.name
        expect(page).to have_content first_order.event_type.name
      end
      expect(page).not_to have_content second_order.more_details
      expect(page).not_to have_content second_event.name
      within('#event_details') do
        expect(page).to have_content first_event.name
        expect(page).to have_content first_event.description
        expect(page).to have_content first_event.menu
        expect(page).to have_content first_event.min_guests
        expect(page).to have_content first_event.max_guests
        expect(page).to have_content first_event.duration
        expect(page).to have_content first_event.event_options[0].name
        expect(page).to have_content first_event.event_options[1].name
        expect(page).to have_content first_event.event_options[2].name
      end

      within('#new_invoice_form') do
        expect(page).to have_content "Orçamento"
        expect(page).to have_content "Preço base"
        expect(page).to have_field "Desconto"
        expect(page).to have_field "Acrescimo"
        expect(page).to have_field "Descrição do valor final"
        expect(page).to have_field "Data limite para confirmação"
        expect(page).to have_content "Métodos de pagamento"
        expect(page).to have_button "Enviar Proposta"
      end

    end
    context "successfully" do
      it 'using base_price' do
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
          event_date: 3.days.from_now,
          guests: 25,
          address: 'Endereço do Evento',
          more_details: 'Evento que acontecerá amanhã',
          customer: customer,
          buffet: buffet,
          event_type: event
        )

        login_as admin, scope: :buffet_admin
        visit root_path
        click_on 'Pedidos'
        click_on order.code
        click_on 'Responder Orçamento'

        within('#new_invoice_form') do
          fill_in "Desconto", with: ''
          fill_in "Acrescimo", with: ''
          fill_in "Descrição do valor final", with: ''
          fill_in "Data limite para confirmação", with: 1.day.from_now
          check payment_methods[0].name
          check payment_methods[2].name
          click_on "Enviar Proposta"
        end

        invoice = Invoice.last
        expect(current_path).to eq order_path(order)
        expect(page).to have_content 'Proposta enviada com sucesso!'
        expect(page).to have_content 'Proposta de Orçamento'
        expect(page).to have_content 'Aprovado, aguardando confirmação do Cliente'
        expect(page).to have_content "Valor: R$#{invoice.final_price}"
        formatted_date = I18n.localize invoice.expiration_date
        expect(page).to have_content "Data limite para confirmação: #{formatted_date}"
        expect(page).to have_content "Métodos de Pagamento"
        expect(page).to have_content payment_methods[0].name
        expect(page).not_to have_content payment_methods[1].name
        expect(page).to have_content payment_methods[2].name

      end

      #using discount
      #using increase
      #using both

      #and needs to insert description
    end
  end
end
