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

      event = EventType.new(name: '')

      event.valid?
      errors = event.errors

      expect(errors.include? :name).to eq true
      expect(errors[:name]).to include 'não pode ficar em branco'

      end

      it "false when missing value of description" do

        event = EventType.new(description: '')

        event.valid?
        errors = event.errors

        expect(errors.include? :description).to eq true
        expect(errors[:description]).to include 'não pode ficar em branco'

      end

      it "false when missing value of menu" do

        event = EventType.new(menu: '')

        event.valid?
        errors = event.errors

        expect(errors.include? :menu).to eq true
        expect(errors[:menu]).to include 'não pode ficar em branco'

      end
      it "false when missing value of location" do

        event = EventType.new(location: '')

        event.valid?
        errors = event.errors

        expect(errors.include? :location).to eq true
        expect(errors[:location]).to include 'não está incluído na lista'

      end

      it "false when missing value of min_guests" do

        event = EventType.new(min_guests: '')

        event.valid?
        errors = event.errors

        expect(errors.include? :min_guests).to eq true
        expect(errors[:min_guests]).to include 'não pode ficar em branco'

      end

      it "false when missing value of max_guests" do

        event = EventType.new(max_guests: '')

        event.valid?
        errors = event.errors

        expect(errors.include? :max_guests).to eq true
        expect(errors[:max_guests]).to include 'não pode ficar em branco'

      end

      it "false when missing value of duration" do

        event = EventType.new(duration: '')

        event.valid?
        errors = event.errors

        expect(errors.include? :duration).to eq true
        expect(errors[:duration]).to include 'não pode ficar em branco'

      end

      it "false when missing value of event_options" do

        event = EventType.new(event_option_ids: [])

        event.valid?
        errors = event.errors

        expect(errors.include? :event_option_ids).to eq true
        expect(errors[:event_option_ids]).to include 'não pode ficar em branco'

      end

      it "false when missing value of buffet" do

        event = EventType.new(buffet: nil)

        event.valid?
        errors = event.errors

        expect(errors.include? :buffet).to eq true
        expect(errors[:buffet]).to include 'é obrigatório(a)'

      end
    end

    context "numericality" do
      context "min_guests.integer?" do
        it "false when min_guests is string" do

          event = EventType.new(min_guests: 'abc')

          event.valid?
          errors = event.errors

          expect(errors.include? :min_guests).to eq true
          expect(errors[:min_guests]).to include 'não é um número'

        end
        it "false when min_guests is float" do

          event = EventType.new(min_guests: 10.5)

          event.valid?
          errors = event.errors

          expect(errors.include? :min_guests).to eq true
          expect(errors[:min_guests]).to include 'não é um número inteiro'

        end
      end
      context "max_guests.integer?" do
        it "false when max_guests is string" do
        event = EventType.new(max_guests: 'abc')

        event.valid?
        errors = event.errors

        expect(errors.include? :max_guests).to eq true
        expect(errors[:max_guests]).to include 'não é um número'
        end
        it "false when max_guests is float" do

          event = EventType.new(max_guests: 10.5)

          event.valid?
          errors = event.errors

          expect(errors.include? :max_guests).to eq true
          expect(errors[:max_guests]).to include 'não é um número inteiro'

        end
      end
      context "duration.integer?" do
        it "false when duration is string" do
          event = EventType.new(duration: 'abc')

          event.valid?
          errors = event.errors

          expect(errors.include? :duration).to eq true
          expect(errors[:duration]).to include 'não é um número'
        end
        it "false when duration is float" do
          event = EventType.new(duration: 10.5)

          event.valid?
          errors = event.errors

          expect(errors.include? :duration).to eq true
          expect(errors[:duration]).to include 'não é um número inteiro'
        end
      end
    end

  end
end
