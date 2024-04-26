require 'rails_helper'

describe "BuffetAdmin signs_up" do
  it "from the root page" do
    #arrange

    #act
    visit root_path
    within 'header'  do
      click_on 'Entrar'
    end
    click_on 'Criar uma conta'

    #assert
    expect(page).to have_content 'Criar uma conta'
    within '#new_buffet_admin_account' do
      expect(page).to have_field 'Nome'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Confirme sua senha'
      expect(page).to have_button 'Criar conta'
    end
  end
  it "successfully" do
    #arrange
    new_user = BuffetAdmin.new(
      name: "Administrador do Buffet",
      email: "buffet@admin.com",
      password: "04dm1n"
    )

    #act
    visit root_path
    within 'header'  do
      click_on 'Entrar'
    end
    click_on 'Criar uma conta'
    within '#new_buffet_admin_account' do
      fill_in 'Nome', with: new_user.name
      fill_in 'E-mail', with: new_user.email
      fill_in 'Senha', with: new_user.password
      fill_in 'Confirme sua senha', with: new_user.password
      click_on 'Criar conta'
    end

    #assert
    expect(current_path).to eq new_buffet_path
    expect(page).to have_content "Olá, #{new_user.name}"
    expect(page).to have_content "Cadastre seu Buffet"
    expect(page).to have_button "Sair"
  end
  it "and leaves name blank" do
    #arrange
    new_user = BuffetAdmin.new(
      name: '',
      email: "buffet@admin.com",
      password: "04dm1n"
    )

    #act
    visit root_path
    within 'header'  do
      click_on 'Entrar'
    end
    click_on 'Criar uma conta'
    within '#new_buffet_admin_account' do
      fill_in 'Nome', with: new_user.name
      fill_in 'E-mail', with: new_user.email
      fill_in 'Senha', with: new_user.password
      fill_in 'Confirme sua senha', with: new_user.password
      click_on 'Criar conta'
    end

    #assert
    expect(current_path).to eq new_buffet_path
    expect(page).to have_content "Olá, #{new_user.email}"
    expect(page).to have_content "Cadastre seu Buffet"
    expect(page).to have_button "Sair"
  end
end
