require 'rails_helper'

RSpec.describe EventPrice, type: :model do
  describe "#valid?" do
    it "true when all is valid" do
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

      base_price = EventPrice.new(
        min_price: 2000,
        extra_guest_fee: 50,
        overtime_fee: 2,
        weekend_schedule: false,
        event_type: event
      )

      #Act & Assert
      expect(base_price.valid?).to eq true
    end

    context "presence" do

      it "false when missing value of min_price" do
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

        base_price = EventPrice.new(
          min_price: '',
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: false,
          event_type: event
        )

        #Act & Assert
        expect(base_price.valid?).to eq false
      end
      it "false when missing value of extra_guest_fee" do
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

        base_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: '',
          overtime_fee: 2,
          weekend_schedule: false,
          event_type: event
        )

        #Act & Assert
        expect(base_price.valid?).to eq false
      end
      it "false when missing value of overtime_fee" do
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

        base_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: '',
          weekend_schedule: false,
          event_type: event
        )

        #Act & Assert
        expect(base_price.valid?).to eq false
      end
      it "false when missing value of weekend_schedule" do
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

        base_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: nil,
          event_type: event
        )

        #Act & Assert
        expect(base_price.valid?).to eq false
      end
      it "false when missing value of event_type" do
        #Arrange
        base_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: false,
          event_type: nil
        )

        #Act & Assert
        expect(base_price.valid?).to eq false
      end

    end

    context "inclusion" do

      it "true when weekend_schedule false" do
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

        base_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: false,
          event_type: event
        )

        #Act & Assert
        expect(base_price.valid?).to eq true
      end
      it "true when weekend_schedule true" do
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

        base_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: true,
          event_type: event
        )

        #Act & Assert
        expect(base_price.valid?).to eq true
      end
    end

    context "numericality" do

      it "false when min_price is string" do
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

        base_price = EventPrice.new(
          min_price: 'dois mil',
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: false,
          event_type: event
        )

        #Act & Assert
        expect(base_price.valid?).to eq false
      end
      it "true when min_price is decimal" do
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

        base_price = EventPrice.new(
          min_price: 2000.50,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: true,
          event_type: event
        )

        #Act & Assert
        expect(base_price.valid?).to eq true
      end
      it "false when extra_guest_fee is string" do
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

        base_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 'cinquenta',
          overtime_fee: 2,
          weekend_schedule: false,
          event_type: event
        )

        #Act & Assert
        expect(base_price.valid?).to eq false
      end
      it "true when extra_guest_fee is decimal" do
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

        base_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 50.50,
          overtime_fee: 2,
          weekend_schedule: true,
          event_type: event
        )

        #Act & Assert
        expect(base_price.valid?).to eq true
      end
      it "false when overtime_fee is string" do
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

        base_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: '2 reais',
          weekend_schedule: false,
          event_type: event
        )

        #Act & Assert
        expect(base_price.valid?).to eq false
      end
      it "true when overtime_fee is decimal" do
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

        base_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2.50,
          weekend_schedule: true,
          event_type: event
        )

        #Act & Assert
        expect(base_price.valid?).to eq true
      end
    end


  end

  describe "#add_to_event_type" do
    context "one record" do
      it 'true when adds one weekday_price' do

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

      weekday_price = EventPrice.new(
        min_price: 2000,
        extra_guest_fee: 50,
        overtime_fee: 2,
        weekend_schedule: false,
        event_type: event
      )

      #Act & Assert
      expect(weekday_price.valid?).to eq true

      end
      it 'true when adds one weekend_price' do
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
      weekend_price = EventPrice.new(
        min_price: 2000,
        extra_guest_fee: 50,
        overtime_fee: 2,
        weekend_schedule: true,
        event_type: event
      )

      #Act & Assert
      expect(weekend_price.valid?).to eq true
      end
    end
    context "two records" do

      it 'true when adds one weekday_price and one weekend_price' do

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
        overtime_fee: 2,
        weekend_schedule: false,
        event_type: event
      )

      weekend_price = EventPrice.new(
        min_price: 2000,
        extra_guest_fee: 50,
        overtime_fee: 2,
        weekend_schedule: true,
        event_type: event
      )

      #Act & Assert
      expect(weekend_price.valid?).to eq true

      end
      it 'true when adds one weekend_price and one weekday_price' do

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

        weekend_price = EventPrice.create!(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: true,
          event_type: event
        )
        weekday_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: false,
          event_type: event
        )

        #Act & Assert
        expect(weekday_price.valid?).to eq true

      end
      it 'false when adds two weekend_price' do
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
        first_weekend_price = EventPrice.create!(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: true,
          event_type: event
        )
        second_weekend_price = EventPrice.new(
          min_price: 2700,
          extra_guest_fee: 55,
          overtime_fee: 20,
          weekend_schedule: true,
          event_type: event
          )
        #Act & Assert
        expect(second_weekend_price.valid?).to eq false

      end
      it 'false when adds two weekday_price' do

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

        first_weekday_price = EventPrice.create!(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: false,
          event_type: event
        )
        second_weekday_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: false,
          event_type: event
        )

        #Act & Assert
        expect(second_weekday_price.valid?).to eq false
      end

    end
    context "three or more records" do
      it 'false when adds one weekday_price and two weekend_price' do
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

        single_weekday_price = EventPrice.create!(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: false,
          event_type: event
        )

        first_weekend_price = EventPrice.create!(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: true,
          event_type: event
        )
        second_weekend_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: true,
          event_type: event
        )

        #Act & Assert
        expect(second_weekend_price.valid?).to eq false
      end
      it 'false when adds one weekend_price and two weekday_price' do
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

        single_weekend_price = EventPrice.create!(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: true,
          event_type: event
        )

        first_weekday_price = EventPrice.create!(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: false,
          event_type: event
        )
        second_weekday_price = EventPrice.new(
          min_price: 2000,
          extra_guest_fee: 50,
          overtime_fee: 2,
          weekend_schedule: false,
          event_type: event
        )

        #Act & Assert
        expect(second_weekday_price.valid?).to eq false

      end
    end
  end
end
