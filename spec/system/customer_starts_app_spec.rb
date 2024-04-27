require 'rails_helper'

describe "Customer starts the app" do
  context "expected behaviour" do
    it "and creates an account" do
      #arrange
      #act
      visit root_path
      click_on 'Entrar como Cliente'
      click_on 'Criar uma conta'

      #assert
      expect(page).to have_content 'Criar conta'
      within '#new_customer_account' do
        expect(page).to have_field 'Nome'
        expect(page).to have_field 'E-mail'
        expect(page).to have_field 'CPF'
        expect(page).to have_field 'Senha'
        expect(page).to have_field 'Confirme sua senha'
        expect(page).to have_button 'Criar conta'
      end
    end
    it "and logs in" do
      #arrange
      #act
      visit root_path
      click_on 'Entrar como Cliente'
      click_on 'Criar uma conta'
      within '#new_customer_account' do
        fill_in 'Nome', with: 'Nome do Cliente'
        fill_in 'E-mail', with: 'cliente@buffet.com'
        fill_in 'CPF', with: '48527862085'
        fill_in 'Senha', with: 'cl13n73'
        fill_in 'Confirme sua senha', with: 'cl13n73'
        click_on 'Criar conta'
      end

      #assert
      expect(page).to have_content 'Olá, Nome do Cliente'
      expect(page).not_to have_content 'Entrar'
      expect(page).to have_button "Sair"
    end
    it "and doesnt manage buffets" do
      #arrange
      customer = Customer.create!(
        name: 'Nome do Cliente',
        social_security_number: "48527862085",
        email: "cliente@buffet.com",
        password: "cl13n73"
      )
      login_as customer, scope: :customer
      #act
      visit new_buffet_path

      #assert
      expect(current_path).to eq root_path
      expect(page).to have_content 'Olá, Nome do Cliente'
      expect(page).to have_content 'Você não possui autorização para essa ação!'
      expect(page).not_to have_content 'Entrar'
      expect(page).to have_button "Sair"
    end

  end
end
