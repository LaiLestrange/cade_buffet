require 'rails_helper'

RSpec.describe EventType, type: :model do
  describe "#valid?" do
    it "true when all valid" do
      #Arrange
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
        EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
        EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
        EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
      ]
      event = EventType.new(
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

      #Act & Assert
      expect(event.valid?).to eq true

    end

    context "presence" do
      it "false when missing value of name" do
        #Arrange
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
        EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
        EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
        EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
      ]
      event = EventType.new(
        name: '',
        description: 'Descrição do evento, propaganda, etc',
        menu: 'Cardápio do evento, tipo de comida etc',
        location: false,
        min_guests: 10,
        max_guests: 50,
        duration: 120,
        event_options: options,
        buffet: buffet
      )

        #Act & Assert
        expect(event.valid?).to eq false

      end

      it "false when missing value of description" do
        #Arrange
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
          EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
          EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
          EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
        ]
        event = EventType.new(
          name: 'Tipo de Evento',
          description: '',
          menu: 'Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: options,
          buffet: buffet
        )

        #Act & Assert
        expect(event.valid?).to eq false
      end

      it "false when missing value of menu" do
        #Arrange
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
          EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
          EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
          EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
        ]
        event = EventType.new(
          name: 'Tipo de Evento',
          description: 'Descrição do evento, propaganda, etc',
          menu: '',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: options,
          buffet: buffet
        )

        #Act & Assert
        expect(event.valid?).to eq false
      end
      it "false when missing value of location" do
        #Arrange
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
          EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
          EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
          EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
        ]
        event = EventType.new(
          name: 'Tipo de Evento',
          description: 'Descrição do evento, propaganda, etc',
          menu: 'Cardápio do evento, tipo de comida etc',
          location: nil,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: options,
          buffet: buffet
        )

        #Act & Assert
        expect(event.valid?).to eq false
      end

      it "false when missing value of min_guests" do
        #Arrange
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
          EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
          EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
          EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
        ]
        event = EventType.new(
          name: 'Tipo de Evento',
          description: 'Descrição do evento, propaganda, etc',
          menu: 'Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: nil,
          max_guests: 50,
          duration: 120,
          event_options: options,
          buffet: buffet
        )

        #Act & Assert
        expect(event.valid?).to eq false
      end

      it "false when missing value of max_guests" do
        #Arrange
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
          EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
          EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
          EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
        ]
        event = EventType.new(
          name: 'Tipo de Evento',
          description: 'Descrição do evento, propaganda, etc',
          menu: 'Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: nil,
          duration: 120,
          event_options: options,
          buffet: buffet
        )

        #Act & Assert
        expect(event.valid?).to eq false
      end

      it "false when missing value of duration" do
        #Arrange
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
          EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
          EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
          EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
        ]
        event = EventType.new(
          name: 'Tipo de Evento',
          description: 'Descrição do evento, propaganda, etc',
          menu: 'Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: nil,
          event_options: options,
          buffet: buffet
        )

        #Act & Assert
        expect(event.valid?).to eq false
      end

      it "false when missing value of event_options" do
        #Arrange
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
        event = EventType.new(
          name: 'Tipo de Evento',
          description: 'Descrição do evento, propaganda, etc',
          menu: 'Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: [],
          buffet: buffet
        )
        #Act & Assert
        expect(event.valid?).to eq false
      end

      it "false when missing value of buffet" do
        #Arrange
        options = [
          EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
          EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
          EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
        ]
        event = EventType.new(
          name: 'Tipo de Evento',
          description: 'Descrição do evento, propaganda, etc',
          menu: 'Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: options,
          buffet: nil
        )
        #Act & Assert
        expect(event.valid?).to eq false
      end
    end

    context "numericality" do
      context "min_guests.integer?" do
        it "false when min_guests is string" do
          #Arrange
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
            EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
            EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
            EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
          ]
          event = EventType.new(
            name: 'Tipo de Evento',
            description: 'Descrição do evento, propaganda, etc',
            menu: 'Cardápio do evento, tipo de comida etc',
            location: false,
            min_guests: 'dez',
            max_guests: 50,
            duration: 120,
            event_options: options,
            buffet: buffet
          )

          #Act & Assert
          expect(event.valid?).to eq false
        end
        it "false when min_guests is float" do
          #Arrange
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
            EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
            EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
            EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
          ]
          event = EventType.new(
            name: 'Tipo de Evento',
            description: 'Descrição do evento, propaganda, etc',
            menu: 'Cardápio do evento, tipo de comida etc',
            location: false,
            min_guests: 10.5,
            max_guests: 50,
            duration: 120,
            event_options: options,
            buffet: buffet
          )

          #Act & Assert
          expect(event.valid?).to eq false
        end
      end
      context "max_guests.integer?" do
        it "false when max_guests is string" do
          #Arrange
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
            EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
            EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
            EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
          ]
          event = EventType.new(
            name: 'Tipo de Evento',
            description: 'Descrição do evento, propaganda, etc',
            menu: 'Cardápio do evento, tipo de comida etc',
            location: false,
            min_guests: 10,
            max_guests: 'cinquenta',
            duration: 120,
            event_options: options,
            buffet: buffet
          )

          #Act & Assert
          expect(event.valid?).to eq false
        end
        it "false when max_guests is float" do
          #Arrange
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
            EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
            EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
            EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
          ]
          event = EventType.new(
            name: 'Tipo de Evento',
            description: 'Descrição do evento, propaganda, etc',
            menu: 'Cardápio do evento, tipo de comida etc',
            location: false,
            min_guests: 10,
            max_guests: 50.5,
            duration: 120,
            event_options: options,
            buffet: buffet
          )

          #Act & Assert
          expect(event.valid?).to eq false
        end
      end
      context "duration.integer?" do
        it "false when duration is string" do
          #Arrange
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
            EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
            EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
            EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
          ]
          event = EventType.new(
            name: 'Tipo de Evento',
            description: 'Descrição do evento, propaganda, etc',
            menu: 'Cardápio do evento, tipo de comida etc',
            location: false,
            min_guests: 10,
            max_guests: 50,
            duration: '2h',
            event_options: options,
            buffet: buffet
          )

          #Act & Assert
          expect(event.valid?).to eq false
        end
        it "false when duration is float" do
          #Arrange
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
            EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
            EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
            EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
          ]
          event = EventType.new(
            name: 'Tipo de Evento',
            description: 'Descrição do evento, propaganda, etc',
            menu: 'Cardápio do evento, tipo de comida etc',
            location: false,
            min_guests: 10.5,
            max_guests: 50,
            duration: 2.5,
            event_options: options,
            buffet: buffet
          )

          #Act & Assert
          expect(event.valid?).to eq false
        end
      end
    end
  end
end
