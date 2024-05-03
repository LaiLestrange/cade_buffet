require 'rails_helper'

describe "BuffetAdmin edits Buffet" do
  it 'and adds payment_methods' do
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

    visit buffet_path(buffet)
    click_on 'Cadastrar Método de Pagamento'
    within('#new_payment_method') do
      fill_in 'Nome', with: 'Pix'
      fill_in 'Detalhes', with: "Chave pix: #{buffet.email}"
      click_on 'Criar Método de Pagamento'
    end

    expect(current_path).to eq new_payment_method_path
    expect(page).to have_content 'Método de Pagamento cadastrado com sucesso!'
    expect(page).to have_content 'Cadastro de Método de Pagamento'
    expect(page).to have_link 'Voltar'
  end

  it 'and see all payment_methods in buffets page' do
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

    visit buffet_path(buffet)
    click_on 'Cadastrar Método de Pagamento'
    fill_in 'Nome', with: 'Pix'
    fill_in 'Detalhes', with: "Chave pix: #{buffet.email}"
    click_on 'Criar Método de Pagamento'
    click_on 'Voltar'

    expect(current_path).to eq buffet_path(buffet)
    expect(page).to have_link 'Cadastrar Método de Pagamento'
    expect(page).to have_content 'Métodos de Pagamento'
    expect(page).to have_content 'Pix'
    expect(page).to have_content "Chave pix: #{buffet.email}"

  end

end
