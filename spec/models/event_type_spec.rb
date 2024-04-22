require 'rails_helper'

RSpec.describe EventType, type: :model do
  describe "#valid?" do
    it "true when all valid" do
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
        event_options: options
      )

      #Act & Assert
      expect(event.valid?).to eq true

    end

    context "presence" do
      it "false when missing value of name" do
        #Arrange
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
          event_options: options
        )

        #Act & Assert
        expect(event.valid?).to eq false

      end

      it "false when missing value of description" do
        #Arrange
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
          event_options: options
        )

        #Act & Assert
        expect(event.valid?).to eq false
      end

      it "false when missing value of menu" do
        #Arrange
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
          event_options: options
        )

        #Act & Assert
        expect(event.valid?).to eq false
      end
      it "false when missing value of location" do
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
          location: nil,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: options
        )

        #Act & Assert
        expect(event.valid?).to eq false
      end

      it "false when missing value of min_guests" do
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
          min_guests: nil,
          max_guests: 50,
          duration: 120,
          event_options: options
        )

        #Act & Assert
        expect(event.valid?).to eq false
      end

      it "false when missing value of max_guests" do
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
          max_guests: nil,
          duration: 120,
          event_options: options
        )

        #Act & Assert
        expect(event.valid?).to eq false
      end

      it "false when missing value of duration" do
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
          duration: nil,
          event_options: options
        )

        #Act & Assert
        expect(event.valid?).to eq false
      end

      it "false when missing value of event_options" do
        #Arrange
        event = EventType.new(
          name: 'Tipo de Evento',
          description: 'Descrição do evento, propaganda, etc',
          menu: 'Cardápio do evento, tipo de comida etc',
          location: false,
          min_guests: 10,
          max_guests: 50,
          duration: 120,
          event_options: []
        )
        #Act & Assert
        expect(event.valid?).to eq false
      end
    end

    context "numericality" do
      context "min_guests.integer?" do
        it "false when min_guests is string" do
          #Arrange
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
            min_guests: '10',
            max_guests: 50,
            duration: 120,
            event_options: options
          )

          #Act & Assert
          expect(event.valid?).to eq false
        end
        it "false when min_guests is float" do
          #Arrange
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
            min_guests: 10.0,
            max_guests: 50,
            duration: 120,
            event_options: options
          )

          #Act & Assert
          expect(event.valid?).to eq false
        end
      end
      context "max_guests.integer?" do
        it "false when max_guests is string" do
          #Arrange
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
            max_guests: '50',
            duration: 120,
            event_options: options
          )

          #Act & Assert
          expect(event.valid?).to eq false
        end
        it "false when max_guests is float" do
          #Arrange
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
            max_guests: 50.0,
            duration: 120,
            event_options: options
          )

          #Act & Assert
          expect(event.valid?).to eq false
        end
      end
      context "duration.integer?" do
        it "false when duration is string" do
          #Arrange
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
            duration: '120',
            event_options: options
          )

          #Act & Assert
          expect(event.valid?).to eq false
        end
        it "false when duration is float" do
          #Arrange
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
            duration: 120.0,
            event_options: options
          )

          #Act & Assert
          expect(event.valid?).to eq false
        end
      end
    end
  end
end
