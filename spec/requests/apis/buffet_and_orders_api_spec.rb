require 'rails_helper'

describe 'Buffet API' do

  context 'GET /api/v1/buffets' do
    it 'success' do
      #Arrange
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
      #Act
      get "/api/v1/buffets"

      #Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse response.body
      expect(json_response.length).to eq 2
      expect(json_response[0]["brand_name"]).to eq first_buffet.brand_name
      expect(json_response[1]["brand_name"]).to eq second_buffet.brand_name
    end
    it 'returns empty if there is no buffet' do
      #arrange
      #act
      get "/api/v1/buffets"
      #assert

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse response.body
      expect(json_response).to eq []
    end
  end

  context 'GET /api/v1/buffets/1' do
    it 'success' do
      #Arrange
      event_options = [
        EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
        EventOption.create!(name: "Decoração",description: "Organização e decoração do espaço do evento"),
        EventOption.create!(name: "Valet",description: "Serviço de estacionamento durante o evento")
      ]
      admin =  BuffetAdmin.create!(
        name: "Administrador de Buffet",
        email: "admin@buffet.com",
        password: "buffetadmin"
      )
      buffet = Buffet.create!(
        brand_name: 'ABC',
        company_name: 'ABC Buffet de Eventos LTDA',
        registration_number: '9999',
        phone_number: '11 1111-1111',
        email: 'eventos@buffet.com',
        full_address: 'Rua dos Eventos, 1',
        state: 'EV',
        city: 'Eventual',
        zip_code: '33333-333',
        description: 'Esse é um Buffet de Eventos',
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

      #Act
      get "/api/v1/buffets/#{buffet.id}"

      #Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse response.body
      expect(json_response["buffet"]["company_name"]).to include buffet.company_name
      expect(json_response["buffet"]["phone_number"]).to include buffet.phone_number
      expect(json_response["buffet"]["email"]).to include buffet.email
      expect(json_response["buffet"]["full_address"]).to include buffet.full_address
      expect(json_response["buffet"]["address"]).to include buffet.address
      expect(json_response["buffet"]["state"]).to include buffet.state
      expect(json_response["buffet"]["city"]).to include buffet.city
      expect(json_response["buffet"]["zip_code"]).to include buffet.zip_code
      expect(json_response["buffet"]["description"]).to include buffet.description
      expect(json_response["buffet"]["buffet_admin_id"]).to eq admin.id
      expect(json_response["buffet"].keys).not_to include "brand_name"
      expect(json_response["buffet"].keys).not_to include "registration_number"
      expect(json_response["event_types"][0]["name"]).to eq first_event.name
      expect(json_response["event_types"][1]["name"]).to eq second_event.name
      expect(json_response["event_types"][2]["name"]).to eq third_event.name
    end

    it 'fail if buffet doesnt exist' do
      #Arrange

      #Act
      get "/api/v1/buffets/9999999"

      #Assert
      expect(response.status).to eq 404
      expect(response.body).to include "Buffet não existe!"
    end
  end

  context 'POST /api/v1/search' do
    it 'searches for buffets' do
      #Arrange
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

      #Act
      post '/api/v1/search', params: { query: 'DEF'}

      #Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse response.body
      expect(json_response.length).to eq 1
      expect(json_response).not_to include first_buffet.brand_name
      expect(json_response.first["brand_name"]).to eq second_buffet.brand_name
      expect(json_response).not_to include third_buffet.brand_name
    end

    it 'found no buffet with specified query' do
      #Arrange

      #Act
      post '/api/v1/search', params: { query: 'no_buffet_to_find'}

      #Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse response.body
      expect(json_response["errors"]).to include "Não há buffet com no_buffet_to_find no nome"

    end

  end
end

describe 'Orders API' do
  context 'POST /api/v1/availability' do
    it 'buffet is available' do

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

      customer = Customer.create!(
          name: 'Fulano Cliente',
          social_security_number: "52383271020",
          email: "cliente1@buffet.com",
          password: "cliente"
        )

      order = Order.create!(
        event_date: 1.month.from_now,
        guests: 25,
        address: 'Endereço do Evento',
        more_details: 'Evento que acontecerá mês que vem',
        customer: customer,
        buffet: buffet,
        event_type: event
      )

      availability_params = {
        event_id: event.id,
        date: 2.months.from_now,
        guests: 45
      }

      post '/api/v1/availability', params: availability_params

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse response.body
      expect(json_response["availability"]).to eq "O Buffet está disponível para realizar esse evento"
      expect(json_response["available"]).to eq true

    end

    context 'buffet is not available' do
      it 'date is already being used' do

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

        customer = Customer.create!(
            name: 'Fulano Cliente',
            social_security_number: "52383271020",
            email: "cliente1@buffet.com",
            password: "cliente"
          )

        order = Order.create!(
          event_date: 1.month.from_now,
          guests: 25,
          address: 'Endereço do Evento',
          more_details: 'Evento que acontecerá mês que vem',
          customer: customer,
          buffet: buffet,
          event_type: event
        )

        availability_params = {
          event_id: event.id,
          date: 1.month.from_now,
          guests: 45
        }

        post '/api/v1/availability', params: availability_params

        expect(response.status).to eq 200
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse response.body
        expect(json_response["availability"]).to eq "O Buffet não está disponível para realizar eventos nesta data"
        expect(json_response["available"]).to eq false

      end
      it 'not enough guests' do

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

        customer = Customer.create!(
            name: 'Fulano Cliente',
            social_security_number: "52383271020",
            email: "cliente1@buffet.com",
            password: "cliente"
          )

        order = Order.create!(
          event_date: 1.month.from_now,
          guests: 25,
          address: 'Endereço do Evento',
          more_details: 'Evento que acontecerá mês que vem',
          customer: customer,
          buffet: buffet,
          event_type: event
        )

        availability_params = {
          event_id: event.id,
          date: 2.months.from_now,
          guests: 5
        }

        post '/api/v1/availability', params: availability_params

        expect(response.status).to eq 200
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse response.body
        expect(json_response["availability"]).to eq "A quantidade mínima de convidados para esse evento não foi atingida"
        expect(json_response["available"]).to eq false

      end
      it 'too much guests' do

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

        customer = Customer.create!(
            name: 'Fulano Cliente',
            social_security_number: "52383271020",
            email: "cliente1@buffet.com",
            password: "cliente"
          )

        order = Order.create!(
          event_date: 1.month.from_now,
          guests: 25,
          address: 'Endereço do Evento',
          more_details: 'Evento que acontecerá mês que vem',
          customer: customer,
          buffet: buffet,
          event_type: event
        )

        availability_params = {
          event_id: event.id,
          date: 2.months.from_now,
          guests: 500
        }

        post '/api/v1/availability', params: availability_params

        expect(response.status).to eq 200
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse response.body
        expect(json_response["availability"]).to eq "A quantidade máxima de convidados para esse evento foi excedida"
        expect(json_response["available"]).to eq false

      end
    end
  end
end
