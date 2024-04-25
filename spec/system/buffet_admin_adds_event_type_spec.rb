require 'rails_helper'

describe "BuffetAdmin adds EventType to Buffet" do
  context "Expected behaviour" do
    it "from their Buffet page" do
      #arrange
      EventOption.create!(
        name: "Bar",
        description: "Serviço de bebida alcóolica durante o evento"
      )
      EventOption.create!(
        name: "Decoração",
        description: "Organização e decoração do espaço do evento"
      )
      EventOption.create!(
        name: "Valet",
        description: "Serviço de estacionamento durante o evento"
      )
      admin = BuffetAdmin.create!(
        name: 'Admin 1 do Buffet',
        email: 'admin1@buffet.com',
        password: 'buff3t'
      )
      buffet = Buffet.create!(
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
        buffet_admin: admin
      )
      login_as admin, scope: :buffet_admin

      #act
      visit root_path
      within('header') do
        click_on admin.name
      end
      click_on 'Cadastrar Evento'

      #assert
      expect(current_path).to eq new_event_type_path
      expect(page).to have_content 'Cadastro de Evento'
      within '#new_event_type'  do
        expect(page).to have_field 'Nome'
        expect(page).to have_field 'Descrição'
        expect(page).to have_field 'Cardápio'
        expect(page).to have_field 'Localização'
        expect(page).to have_field 'Mínimo de Convidados'
        expect(page).to have_field 'Máximo de Convidados'
        expect(page).to have_field 'Duração'
        expect(page).to have_field 'Bar'
        expect(page).to have_field 'Decoração'
        expect(page).to have_field 'Valet'
        expect(page).to have_button 'Criar Evento'
      end
    end
    it "successfully" do
      #arrange
      admin = BuffetAdmin.create!(
        name: 'Admin 1 do Buffet',
        email: 'admin1@buffet.com',
        password: 'buff3t'
      )
      buffet = Buffet.create!(
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
        buffet_admin: admin
      )
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
      login_as admin, scope: :buffet_admin

      #act
      visit root_path
      within('header') do
        click_on admin.name
      end
      click_on 'Cadastrar Evento'
      within '#new_event_type'  do
       fill_in 'Nome', with: 'Tipo de Evento'
       fill_in 'Descrição', with: 'Descrição do evento, propaganda, etc'
       fill_in 'Cardápio', with: 'Cardápio do evento, tipo de comida, etc'
       check 'Localização'
       fill_in 'Mínimo de Convidados', with: '10'
       fill_in 'Máximo de Convidados', with: '50'
       fill_in 'Duração', with: '120'
       check options[0].name
       check options[2].name
       click_on 'Criar Evento'
      end

      #assert
      expect(current_path).to eq buffet_path buffet.id
      expect(page).to have_content 'Evento cadastrado com sucesso!'
      expect(page).to have_content 'Tipo de Evento'
      expect(page).to have_content 'Descrição do evento, propaganda, etc'
      expect(page).to have_content 'Cardápio do evento, tipo de comida, etc'
      expect(page).to have_content 'Você pode escolher a localização do evento!'
      expect(page).to have_content 'De 10 a 50 convidados'
      expect(page).to have_content 'Duração: 120min'
      expect(page).to have_content 'Serviços Inclusos'
      expect(page).to have_content 'Bar'
      expect(page).to have_content 'Valet'
    end

  end
  context "Unexpected behaviour" do
    it "and leaves out missing information" do
      #arrange
      admin = BuffetAdmin.create!(
        name: 'Admin 1 do Buffet',
        email: 'admin1@buffet.com',
        password: 'buff3t'
      )
      buffet = Buffet.create!(
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
        buffet_admin: admin
      )
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
      login_as admin, scope: :buffet_admin

      #act
      visit root_path
      within('header') do
        click_on admin.name
      end
      click_on 'Cadastrar Evento'
      within '#new_event_type'  do
       fill_in 'Nome', with: ''
       fill_in 'Descrição', with: ''
       fill_in 'Cardápio', with: 'Cardápio do evento, tipo de comida, etc'
       check 'Localização'
       fill_in 'Mínimo de Convidados', with: '10'
       fill_in 'Máximo de Convidados', with: '50'
       fill_in 'Duração', with: '120'
       check options[0].name
       check options[2].name
       click_on 'Criar Evento'
      end

      #assert
      expect(current_path).to eq event_types_path
      expect(page).to have_content 'Evento não cadastrado!'
    end
    it "tries to create new event_type for other's buffet" do
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
      login_as first_admin, scope: :buffet_admin

      #act
      visit new_event_type_path
      within('header') do
        click_on first_admin.name
      end
      click_on 'Cadastrar Evento'
      within '#new_event_type'  do
       fill_in 'Nome', with: 'Nome do Evento'
       fill_in 'Descrição', with: 'Descrição do Evento'
       fill_in 'Cardápio', with: 'Cardápio do evento, tipo de comida, etc'
       check 'Localização'
       fill_in 'Mínimo de Convidados', with: '10'
       fill_in 'Máximo de Convidados', with: '50'
       fill_in 'Duração', with: '120'
       check options[0].name
       check options[2].name
       click_on 'Criar Evento'
      end

      event = EventType.last

      #assert
      expect(event.buffet.id).to eq first_buffet.id
      expect(event.buffet.id).not_to eq second_buffet.id
    end
  end
end
