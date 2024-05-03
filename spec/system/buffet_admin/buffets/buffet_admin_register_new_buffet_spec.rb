require 'rails_helper'

describe "BuffetAdmin register Buffet" do
  it "right after registering their new account" do
    buffet_admin = BuffetAdmin.new(
      name: "Administrador do Buffet",
      email: "buffet@admin.com",
      password: "04dm1n"
    )

    visit root_path
    within 'header'  do
      click_on 'Entrar como Administrador'
    end
    click_on 'Criar uma conta'
    within "#new_buffet_admin_account" do
      fill_in 'Nome', with: buffet_admin.name
      fill_in 'E-mail', with: buffet_admin.email
      fill_in 'Senha', with: buffet_admin.password
      fill_in 'Confirme sua senha', with: buffet_admin.password
      click_on 'Criar conta'
    end

    expect(current_path).to eq new_buffet_path
    expect(page).to have_button "Sair"
    expect(page).to have_content "Cadastro de Buffet"
    within('#new_buffet') do
      expect(page).to have_field 'Nome Fantasia'
      expect(page).to have_field 'Descrição'
      expect(page).to have_field 'Nome de Registro'
      expect(page).to have_field 'CNPJ'
      expect(page).to have_field 'Telefone'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Endereço'
      expect(page).to have_field 'Estado'
      expect(page).to have_field 'Cidade'
      expect(page).to have_field 'CEP'
      expect(page).to have_button 'Criar Buffet'
    end
  end
  it 'and cant access other routes before registering the buffet' do
    admin = BuffetAdmin.create!(
      name: "Administrador Errado",
      email: "errado@admin.com",
      password: "3rr0r4dm1n"
    )
    login_as admin, scope: :buffet_admin

    visit root_path

    expect(current_path).to eq new_buffet_path
  end
  it 'and tries to leave out some information' do
    admin = BuffetAdmin.create!(
      name: "Administrador Errado",
      email: "errado@admin.com",
      password: "3rr0r4dm1n"
    )
    login_as admin, scope: :buffet_admin

    visit root_path
    within('#new_buffet') do
      fill_in 'Nome Fantasia', with: ''
      fill_in 'Descrição', with: 'Um buffet que provê serviços de eventos'
      fill_in 'Nome de Registro', with: ''
      fill_in 'CNPJ', with: ''
      fill_in 'Telefone', with: '11 2222-3333'
      fill_in 'E-mail', with: 'eventos@buffet.com'
      fill_in 'Endereço', with: 'Rua dos Eventos, 12'
      fill_in 'Estado', with: 'EV'
      fill_in 'Cidade', with: 'Eventualidade'
      fill_in 'CEP', with: '34567-891'
      click_on 'Criar Buffet'
    end

    # expect(current_path).to eq buffets_path ???
    expect(page).to have_content 'Cadastre seu Buffet'
    expect(page).to have_content 'Um buffet que provê serviços de eventos'
  end
  it 'and does it successfully from root_path' do
    buffet_admin = BuffetAdmin.create!(
      name: "Administrador do Buffet",
      email: "buffet@admin.com",
      password: "04dm1n"
    )
    login_as(buffet_admin, scope: :buffet_admin)

    visit root_path
    within('#new_buffet') do
      fill_in 'Nome Fantasia', with: 'Eventos Buffet'
      fill_in 'Descrição', with: 'Um buffet que provê serviços de eventos'
      fill_in 'Nome de Registro', with: 'Buffet de Eventos LTDA'
      fill_in 'CNPJ', with: '333-456'
      fill_in 'Telefone', with: '11 2222-3333'
      fill_in 'E-mail', with: 'eventos@buffet.com'
      fill_in 'Endereço', with: 'Rua dos Eventos, 12'
      fill_in 'Estado', with: 'EV'
      fill_in 'Cidade', with: 'Eventualidade'
      fill_in 'CEP', with: '34567-891'
      click_on 'Criar Buffet'
    end

    buffet = Buffet.last
    expect(current_path).to eq buffet_path(buffet.id)
    expect(page).to have_content 'Eventos Buffet'
    expect(page).to have_content 'Um buffet que provê serviços de eventos'
    expect(page).to have_content 'Buffet de Eventos LTDA'
    expect(page).to have_content '333-456'
    expect(page).to have_content '11 2222-3333'
    expect(page).to have_content 'eventos@buffet.com'
    expect(page).to have_content 'Rua dos Eventos, 12'
    expect(page).to have_content 'EV'
    expect(page).to have_content 'Eventualidade'
    expect(page).to have_content '34567-891'
    expect(page).to have_content 'eventos@buffet.com'
  end

  it 'and tries to register a second buffet' do
    admin = BuffetAdmin.create!(
      name: "Administrador Errado",
      email: "errado@admin.com",
      password: "3rr0r4dm1n"
    )

    buffet = Buffet.create!(
      brand_name: 'Eventos Buffet',
      company_name: 'Buffet de Eventos LTDA',
      registration_number: '123456789',
      phone_number: '11 1111-1111',
      email: 'eventos@buffet.com',
      full_address: 'Rua dos Eventos, 2',
      state: 'EV',
      city: 'Eventual',
      zip_code: '33333-333',
      description: 'Esse é um Buffet de Eventos',
      buffet_admin: admin
    )

    login_as admin, scope: :buffet_admin

    visit new_buffet_path

    expect(current_path).to eq buffet_path(buffet)
    expect(page).to have_content "Já possui um Buffet cadastrado!"
  end
end
