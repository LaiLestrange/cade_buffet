require 'rails_helper'

describe "BuffetAdmin opens the app" do
  it "and is not logged in" do
    #arrange

    #act
    visit root_path

    #assert
    expect(page).to have_content 'Cadê Buffet?'
    within 'header' do
      expect(page).to have_link 'Entrar'
    end
  end

  it 'and logs in successfully' do
    #arrange
    admin = BuffetAdmin.create!(
      name: "Administrador do Buffet",
      email: "buffet@admin.com",
      password: "04dm1n"
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
      buffet_admin_id: admin.id
    )

    #act
    visit root_path
    within 'header'  do
      click_on 'Entrar'
    end
    fill_in 'E-mail', with: admin.email
    fill_in 'Senha', with: admin.password
    within 'form' do
      click_on 'Entrar'
    end

    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content "Olá, #{admin.name}"
    expect(page).to have_button "Sair"
  end

  it 'and logs out successfully' do
    #arrange
    admin = BuffetAdmin.create!(
      name: "Ademir do Buffet",
      email: "buffet@adm.com",
      password: "04dm1n"
    )

    login_as admin, scope: :buffet_admin

    #act
    visit root_path
    within 'header'  do
      click_on 'Sair'
    end

    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
  end
end
