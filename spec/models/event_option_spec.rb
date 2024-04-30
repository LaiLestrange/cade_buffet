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
        option = EventOption.new(name: '')
        option.valid?
        errors = option.errors

        expect(errors.include? :name).to eq true
        expect(errors[:name]).to include 'não pode ficar em branco'
      end

      it "false when missing value of description" do
        option = EventOption.new(description: '')
        option.valid?
        errors = option.errors

        expect(errors.include? :description).to eq true
        expect(errors[:description]).to include 'não pode ficar em branco'
      end
    end

  end
end
