require 'rails_helper'

describe "User opens the app" do
  context 'First Steps' do
    it "and is not logged in" do
      #arrange
      options = [
        EventOption.create!(
          name: "Bar",
          description: "Serviço de bebida alcóolica durante o evento"
        ),
        EventOption.create!(
          name: "Decoração",
          description: "Organização e decoração do espaço do evento"
        ),
        EventOption.create!(
          name: "Valet",
          description: "Serviço de estacionamento durante o evento"
        ),
      ]
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
        buffet_admin: first_admin
      )
      second_admin = BuffetAdmin.create!(
        name: 'Admin 2 do Buffet',
        email: 'admin2@buffet.com',
        password: 'buff3t'
      )
      second_buffet = Buffet.create!(
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
        buffet_admin: second_admin
      )
      #act
      visit root_path

      #assert
      expect(current_path).to eq root_path
      expect(page).to have_content 'Buffets'
      expect(page).to have_content first_buffet.brand_name
      expect(page).to have_content first_buffet.city
      expect(page).to have_content first_buffet.state
      expect(page).to have_content second_buffet.brand_name
      expect(page).to have_content second_buffet.city
      expect(page).to have_content second_buffet.state
    end

    it 'and chooses a buffet to see the details' do
      #arrange
      admin = BuffetAdmin.create!(
        name: "Administrador de Buffet",
        email: "admin@buffet.com",
        password: "8uff374dm1n"
      )
      buffet = Buffet.create!(
        brand_name: 'Eventos Buffet',
        company_name: 'Buffet de Eventos LTDA',
        registration_number: '123456789',
        phone_number: '11 1111-1111',
        email: 'eventos@buffet.com',
        full_address: 'Rua dos Eventos, 2',
        state: 'EV',
        city: 'Eventual',
        zip_code: '33333-333',
        description: 'Esse é um Buffet de Eventos',
        buffet_admin: admin
      )
      options = [
        EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
        EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
        EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
      ]
      event = EventType.create!(
        name: 'Tipo de Evento',
        description: 'Descrição do evento, propaganda, etc',
        menu: 'Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: options,
        buffet: buffet
      )
      weekday_price = EventPrice.create!(
        min_price: 2000,
        extra_guest_fee: 50,
        overtime_fee: 25,
        weekend_schedule: false,
        event_type: event
      )
      weekend_price = EventPrice.create!(
        min_price: 2000,
        extra_guest_fee: 50,
        overtime_fee: 25,
        weekend_schedule: true,
        event_type: event
      )
      payment_method = PaymentMethod.create!(
        name: 'Método de Pagamento',
        details: 'Método de Pagamento que o Buffet pode oferecer',
        buffet: buffet
      )
      #act
      visit root_path
      click_on buffet.brand_name

      #assert
      expect(current_path).to eq buffet_path(buffet)
      expect(page).to have_content buffet.company_name
      expect(page).not_to have_content buffet.registration_number
    end

    it 'and sees the details of an event' do
       #arrange
       admin = BuffetAdmin.create!(
        name: "Administrador de Buffet",
        email: "admin@buffet.com",
        password: "8uff374dm1n"
      )
      buffet = Buffet.create!(
        brand_name: 'Eventos Buffet',
        company_name: 'Buffet de Eventos LTDA',
        registration_number: '123456789',
        phone_number: '11 1111-1111',
        email: 'eventos@buffet.com',
        full_address: 'Rua dos Eventos, 2',
        state: 'EV',
        city: 'Eventual',
        zip_code: '33333-333',
        description: 'Esse é um Buffet de Eventos',
        buffet_admin: admin
      )
      options = [
        EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
        EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
        EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
      ]
      event = EventType.create!(
        name: 'Tipo de Evento',
        description: 'Descrição do evento, propaganda, etc',
        menu: 'Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: options,
        buffet: buffet
      )
      weekday_price = EventPrice.create!(
        min_price: 2000,
        extra_guest_fee: 50,
        overtime_fee: 25,
        weekend_schedule: false,
        event_type: event
      )
      weekend_price = EventPrice.create!(
        min_price: 2500,
        extra_guest_fee: 70,
        overtime_fee: 60,
        weekend_schedule: true,
        event_type: event
      )
      payment_method = PaymentMethod.create!(
        name: 'Método de Pagamento',
        details: 'Método de Pagamento que o Buffet pode oferecer',
        buffet: buffet
      )

      
      #act
      visit root_path
      click_on buffet.brand_name
      click_on event.name

      #assert
      expect(current_path).to eq event_type_path(event)
      expect(page).to have_content event.menu
      expect(page).to have_content 'R$ 2.000,00'
      expect(page).to have_content 'R$ 70,00'

    end
  end
end
