require 'rails_helper'

RSpec.describe EventOption, type: :model do
  describe "#valid?" do
    it "true when all valid" do
      #Arrange
      option = EventOption.new(
        name: 'Opção de Serviço',
        description: 'Serviço que o Buffet pode oferecer'
      )

      #Act & Assert
      expect(option.valid?).to eq true

    end
    context "presence" do
      it "false when missing value of name" do
        #Arrange
        option = EventOption.new(
          name: '',
          description: 'Serviço que o Buffet pode oferecer'
        )

        #Act & Assert
        expect(option.valid?).to eq false
      end

      it "false when missing value of description" do
        #Arrange
        option = EventOption.new(
          name: 'Opção de Serviço',
          description: ''
        )

        #Act & Assert
        expect(option.valid?).to eq false
      end
    end

  end
end
