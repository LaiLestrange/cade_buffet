require 'rails_helper'

describe "User searches for buffet" do
  context 'expected behaviour' do
    it "from the root page" do
      #arrange
      #act
      visit root_path
      #assert
      expect(page).to have_field 'Procurar Buffets'
    end
    it "and searches by buffet.brand_name" do
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
        brand_name: 'Eventos 1 Buffet PESQUISA',
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
      first_event = EventType.create!(
        name: 'Tipo de Evento',
        description: 'Descrição do evento, propaganda, etc',
        menu: 'Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: options,
        buffet: first_buffet
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
      second_event = EventType.create!(
        name: 'Tipo de Evento',
        description: 'Descrição do evento, propaganda, etc',
        menu: 'Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: options,
        buffet: second_buffet
      )

      #act
      visit root_path
      fill_in 'Procurar Buffets', with: 'PESQUISA'
      click_on 'Pesquisar'

      #assert
      expect(page).to have_content first_buffet.brand_name
      expect(page).to have_content first_buffet.city
      expect(page).to have_content first_buffet.state
    end
    it "and searches by buffet.city" do
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
        city: 'Eventuais PESQUISA',
        zip_code: '11111-111',
        description: 'A descrição do primeiro buffet',
        buffet_admin: first_admin
      )
      first_event = EventType.create!(
        name: 'Tipo de Evento',
        description: 'Descrição do evento, propaganda, etc',
        menu: 'Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: options,
        buffet: first_buffet
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
      second_event = EventType.create!(
        name: 'Tipo de Evento',
        description: 'Descrição do evento, propaganda, etc',
        menu: 'Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: options,
        buffet: second_buffet
      )


      #act
      visit root_path
      fill_in 'Procurar Buffets', with: 'PESQUISA'
      click_on 'Pesquisar'

      #assert
      expect(page).to have_content first_buffet.brand_name
      expect(page).to have_content first_buffet.city
      expect(page).to have_content first_buffet.state
    end
    it "and searches by event.name" do
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
        city: 'Eventuais PESQUISA',
        zip_code: '11111-111',
        description: 'A descrição do primeiro buffet',
        buffet_admin: first_admin
      )
      first_event = EventType.create!(
        name: 'Tipo de Evento PESQUISA',
        description: 'Descrição do evento, propaganda, etc',
        menu: 'Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: options,
        buffet: first_buffet
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
      second_event = EventType.create!(
        name: 'Tipo de Evento',
        description: 'Descrição do evento, propaganda, etc',
        menu: 'Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: options,
        buffet: second_buffet
      )

      #act
      visit root_path
      fill_in 'Procurar Buffets', with: 'PESQUISA'
      click_on 'Pesquisar'

      #assert
      expect(page).to have_content ''
    end
    it "and sees it ordered alphabetically" do
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
        brand_name: 'B Eventos 1 Buffet',
        company_name: 'Buffet 1 de Eventos LTDA',
        registration_number: '123456789',
        phone_number: '11 11111-1111',
        email: 'buffet1@buffet.com',
        full_address: 'Rua dos Buffets, 11, Bairro dos Eventos',
        state: 'BF',
        city: 'Eventuais PESQUISA',
        zip_code: '11111-111',
        description: 'A descrição do primeiro buffet',
        buffet_admin: first_admin
      )
      first_event = EventType.create!(
        name: 'Tipo de Evento PESQUISA',
        description: 'Descrição do evento, propaganda, etc',
        menu: 'Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: options,
        buffet: first_buffet
      )
      second_admin = BuffetAdmin.create!(
        name: 'Admin 2 do Buffet',
        email: 'admin2@buffet.com',
        password: 'buff3t'
      )
      second_buffet = Buffet.create!(
        brand_name: 'A Eventos 2 Buffet PESQUISA',
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
      second_event = EventType.create!(
        name: 'Tipo de Evento',
        description: 'Descrição do evento, propaganda, etc',
        menu: 'Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: options,
        buffet: second_buffet
      )

      #act
      visit root_path
      fill_in 'Procurar Buffets', with: 'PESQUISA'
      click_on 'Pesquisar'

      #assert
      within ('#buffet_search > div:nth-child(1)') do
        expect(page).to have_content second_buffet.brand_name
      end
      within ('#buffet_search > div:nth-child(2)') do
        expect(page).to have_content first_buffet.brand_name
      end
    end
  end
end
