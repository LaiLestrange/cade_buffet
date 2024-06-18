require 'rails_helper'

describe "BuffetAdmin starts the app" do
  it 'and logs in successfully' do
    # admin = BuffetAdmin.create!(
    #   name: "Administrador do Buffet",
    #   email: "buffet@admin.com",
    #   password: "04dm1n"
    # )

    # admin = FactoryBot.create :buffet_admin

    # buffet = Buffet.create!(
    #   brand_name: 'Eventos Buffet',
    #   company_name: 'Buffet de Eventos LTDA',
    #   registration_number: '123456789',
    #   phone_number: '11 1111-1111',
    #   email: 'eventos@buffet.com',
    #   full_address: 'Rua dos Eventos, 2',
    #   state: 'EV',
    #   city: 'Eventual',
    #   zip_code: '33333-333',
    #   description: 'Esse é um Buffet de Eventos',
    #   buffet_admin: admin
    # )

    # buffet = FactoryBot.create(:buffet, buffet_admin: admin)
    buffet = FactoryBot.create :buffet

    visit root_path
    within 'header'  do
      click_on 'Entrar como Administrador'
    end
    fill_in 'E-mail', with: buffet.buffet_admin.email
    fill_in 'Senha', with: buffet.buffet_admin.password
    within '#new_buffet_admin_session' do
      click_on 'Entrar'
    end

    expect(current_path).to eq buffet_path(buffet)
    expect(page).to have_content "Olá, #{buffet.buffet_admin.name}"
    expect(page).to have_button "Sair"
  end

  it 'and logs out successfully' do
    admin = BuffetAdmin.create!(
      name: "Ademir do Buffet",
      email: "buffet@adm.com",
      password: "04dm1n"
    )

    login_as admin, scope: :buffet_admin

    visit root_path
    within 'header'  do
      click_on 'Sair'
    end

    expect(current_path).to eq root_path
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar como Administrador'
  end

  it 'and goes from root to their Buffet page' do
    # admin = BuffetAdmin.create!(
    #   name: "Administrador do Buffet",
    #   email: "buffet@admin.com",
    #   password: "04dm1n"
    # )
    # buffet = Buffet.create!(
    #   brand_name: 'Eventos Buffet',
    #   company_name: 'Buffet de Eventos LTDA',
    #   registration_number: '123456789',
    #   phone_number: '11 1111-1111',
    #   email: 'eventos@buffet.com',
    #   full_address: 'Rua dos Eventos, 2',
    #   state: 'EV',
    #   city: 'Eventual',
    #   zip_code: '33333-333',
    #   description: 'Esse é um Buffet de Eventos',
    #   buffet_admin: admin
    # )
    buffet = FactoryBot.create :buffet

    login_as buffet.buffet_admin, scope: :buffet_admin

    visit root_path
    within 'header'  do
      click_on buffet.buffet_admin.name
    end
    expect(current_path).to eq buffet_path buffet.id
    expect(page).to have_content buffet.brand_name
    expect(page).not_to have_content 'Pedir um Orçamento'
  end

end
