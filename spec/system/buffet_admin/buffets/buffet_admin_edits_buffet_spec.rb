require 'rails_helper'

describe "BuffetAdmin edits Buffet" do
  it "from the buffet page" do
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
      buffet_admin: admin
    )
    login_as admin, scope: :buffet_admin

    visit root_path
    within('header') do
      click_on admin.name
    end
    click_on 'Editar Buffet'

    expect(current_path).to eq edit_buffet_path(buffet)
    within('#edit_buffet') do
      expect(page).to have_field 'Nome Fantasia', with: buffet.brand_name
      expect(page).to have_field 'Descrição', with: buffet.description
      expect(page).to have_field 'Nome de Registro', with: buffet.company_name
      expect(page).not_to have_field 'CNPJ'
      expect(page).to have_field 'Telefone', with: buffet.phone_number
      expect(page).to have_field 'E-mail', with: buffet.email
      expect(page).to have_field 'Endereço', with: buffet.full_address
      expect(page).to have_field 'Estado', with: buffet.state
      expect(page).to have_field 'Cidade', with: buffet.city
      expect(page).to have_field 'CEP', with: buffet.zip_code
      expect(page).to have_button 'Atualizar Buffet'
    end
  end

  it "successfully" do
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
      buffet_admin: admin
    )
    login_as admin, scope: :buffet_admin

    visit root_path
    within('header') do
      click_on admin.name
    end
    click_on 'Editar Buffet'
    fill_in 'Nome Fantasia', with: 'Buffet Eventos'
    fill_in 'Descrição', with: 'Essa é uma descrição do Buffet, adicionada depois.'
    click_on 'Atualizar Buffet'

    expect(current_path).to eq buffet_path(buffet)
    expect(page).to have_content 'Buffet atualizado com sucesso!'
    expect(page).to have_content 'Buffet Eventos'
    expect(page).to have_content 'Essa é uma descrição do Buffet, adicionada depois.'
  end

  it 'and respecting validations' do
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
      buffet_admin: admin
    )
    login_as admin, scope: :buffet_admin

    visit root_path
    within('header') do
      click_on admin.name
    end
    click_on 'Editar Buffet'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Nome de Registro', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Atualizar Buffet'

    expect(page).to have_content 'Não foi possível atualizar o Buffet!'
    expect(page).to have_field 'Nome Fantasia', with: ''
  end

  it "and tries to see not owned buffet" do
    first_admin = BuffetAdmin.create!(
      name: 'Admin 1 do Buffet',
      email: 'admin1@buffet.com',
      password: 'buff3t'
    )
    first_buffet = Buffet.create!(
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
      buffet_admin: first_admin
    )

    second_admin = BuffetAdmin.create!(
      name: 'Admin 2 do Buffet',
      email: 'admin2@buffet.com',
      password: 'buff3t'
    )
    second_buffet = Buffet.create!(
      brand_name: 'Eventos 2 Buffet',
      company_name: 'Buffet 2 de Eventos LTDA',
      registration_number: '234567891',
      phone_number: '22 22222-2222',
      email: 'buffet2@buffet.com',
      full_address: 'Rua dos Buffets, 12, Bairro dos Eventos',
      state: 'BF',
      city: 'Eventuais',
      zip_code: '22222-222',
      description: 'A descrição do secundo buffet',
      buffet_admin: second_admin
    )
    login_as first_admin, scope: :buffet_admin

    visit buffet_path(second_buffet)

    expect(current_path).to eq buffet_path(first_buffet)
    expect(page).to have_content first_buffet.brand_name
  end

  it "and tries to edit not owned buffet" do
    first_admin = BuffetAdmin.create!(
      name: 'Admin 1 do Buffet',
      email: 'admin1@buffet.com',
      password: 'buff3t'
    )
    first_buffet = Buffet.create!(
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
      buffet_admin: first_admin
    )

    second_admin = BuffetAdmin.create!(
      name: 'Admin 2 do Buffet',
      email: 'admin2@buffet.com',
      password: 'buff3t'
    )
    second_buffet = Buffet.create!(
      brand_name: 'Eventos 2 Buffet',
      company_name: 'Buffet 2 de Eventos LTDA',
      registration_number: '234567891',
      phone_number: '22 22222-2222',
      email: 'buffet2@buffet.com',
      full_address: 'Rua dos Buffets, 12, Bairro dos Eventos',
      state: 'BF',
      city: 'Eventuais',
      zip_code: '22222-222',
      description: 'A descrição do secundo buffet',
      buffet_admin: second_admin
    )

    login_as first_admin, scope: :buffet_admin

    visit edit_buffet_path(second_buffet)

    expect(current_path).to eq edit_buffet_path(first_buffet)
  end
end
