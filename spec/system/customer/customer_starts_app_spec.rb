require 'rails_helper'

describe "Customer starts the app" do
  it "and logs in successfully" do
    # customer = Customer.create!(
    #   name: 'Nome do Cliente',
    #   social_security_number: "48527862085",
    #   email: "cliente@buffet.com",
    #   password: "cl13n73"
    # )
    customer = FactoryBot.create(:customer, name: 'Nome do Cliente')
    puts customer.email

    visit root_path

    click_on 'Entrar como Cliente'
    within '#new_customer_session' do
      fill_in 'E-mail', with: customer.email
      fill_in 'Senha', with: customer.password
      click_on 'Entrar'
    end

    expect(page).to have_content 'Olá, Nome do Cliente'
    expect(page).not_to have_content 'Entrar'
    expect(page).to have_button "Sair"
  end

  it "and doesnt manage buffets" do
    customer = Customer.create!(
      name: 'Nome do Cliente',
      social_security_number: "48527862085",
      email: "cliente@buffet.com",
      password: "cl13n73"
    )
    login_as customer, scope: :customer

    visit new_buffet_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Olá, Nome do Cliente'
    expect(page).to have_content 'Você não possui autorização para essa ação!'
    expect(page).not_to have_content 'Entrar'
    expect(page).to have_button "Sair"
  end

  it "and logs out successfully" do
    customer = Customer.create!(
      name: 'Nome do Cliente',
      social_security_number: "48527862085",
      email: "cliente@buffet.com",
      password: "cl13n73"
    )
    login_as customer, scope: :customer
    visit root_path
    within 'header'  do
      click_on 'Sair'
    end

    expect(current_path).to eq root_path
    expect(page).to have_content 'Logout efetuado com sucesso.'
  end

end
