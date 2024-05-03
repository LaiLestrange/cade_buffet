require 'rails_helper'

describe "BuffetAdmin adds Price to Event" do
  it "from the Buffet page" do
    admin = BuffetAdmin.create!(
      name: 'Admin 1 do Buffet',
      email: 'admin1@buffet.com',
      password: 'buff3t'
    )
    buffet = Buffet.create!(
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
      buffet_admin: admin
    )
    options = [
      EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
      EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
      EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
    ]
    event = EventType.create!(
      name: 'Tipo de Evento',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: buffet
    )
    login_as admin, scope: :buffet_admin

    visit buffet_path(buffet)
    click_on event.name
    click_on 'Adicionar Preço'

    expect(current_path).to eq new_event_price_path
    expect(page).to have_content 'Adicionar Preço ao Evento'
    within('#new_event_price') do
      expect(page).to have_field 'Preço Inicial'
      expect(page).to have_field 'Taxa por convidado extra'
      expect(page).to have_field 'Taxa por hora extra'
      expect(page).to have_field 'Preço de Final de Semana'
      expect(page).to have_button 'Criar Preço'
    end
  end

  it "and adds first price" do
    admin = BuffetAdmin.create!(
      name: 'Admin 1 do Buffet',
      email: 'admin1@buffet.com',
      password: 'buff3t'
    )
    buffet = Buffet.create!(
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
      buffet_admin: admin
    )
    options = [
      EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
      EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
      EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
    ]
    event = EventType.create!(
      name: 'Tipo de Evento',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: buffet
    )
    login_as admin, scope: :buffet_admin

    visit buffet_path(buffet)
    click_on event.name
    click_on 'Adicionar Preço'
    within('#new_event_price') do
      fill_in 'Preço Inicial', with: '2000'
      fill_in 'Taxa por convidado extra', with: '50'
      fill_in 'Taxa por hora extra', with: '50'
      check 'Preço de Final de Semana'
      click_on 'Criar Preço'
    end

    expect(current_path).to eq event_type_path(event)
    expect(page).to have_content 'Preço cadastrado com sucesso!'
    expect(page).to have_content 'Preço Inicial: R$ 2.000,00'
    expect(page).to have_content 'R$ 50,00 por convidado extra'
    expect(page).to have_content 'R$ 50,00 por hora extra'
  end

  it "and cant add two of the same type" do
    admin = BuffetAdmin.create!(
      name: 'Admin 1 do Buffet',
      email: 'admin1@buffet.com',
      password: 'buff3t'
    )
    buffet = Buffet.create!(
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
      buffet_admin: admin
    )
    options = [
      EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
      EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
      EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
    ]
    event = EventType.create!(
      name: 'Tipo de Evento',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: buffet
    )
    weekend_price = EventPrice.create!(
      min_price: 2000,
      extra_guest_fee: 50,
      overtime_fee: 25,
      weekend_schedule: true,
      event_type: event
    )
    login_as admin, scope: :buffet_admin

    visit buffet_path(buffet)
    click_on event.name
    click_on 'Adicionar Preço'
    within('#new_event_price') do
      fill_in 'Preço Inicial', with: '2750'
      fill_in 'Taxa por convidado extra', with: '75'
      fill_in 'Taxa por hora extra', with: '80'
      check 'Preço de Final de Semana'
      click_on 'Criar Preço'
    end

    expect(current_path).to eq event_prices_path
    expect(page).to have_content 'Preço não foi cadastrado!'
    expect(page).to have_field 'Preço Inicial', with: '2750'
    expect(page).to have_field 'Taxa por convidado extra', with: '75'
    expect(page).to have_field 'Taxa por hora extra', with: '80'
  end

  it "and adds second price" do
    admin = BuffetAdmin.create!(
      name: 'Admin 1 do Buffet',
      email: 'admin1@buffet.com',
      password: 'buff3t'
    )
    buffet = Buffet.create!(
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
      buffet_admin: admin
    )
    options = [
      EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
      EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
      EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
    ]
    event = EventType.create!(
      name: 'Tipo de Evento',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: buffet
    )
    weekday_price = EventPrice.create!(
      min_price: 2000,
      extra_guest_fee: 50,
      overtime_fee: 25,
      weekend_schedule: false,
      event_type: event
    )
    login_as admin, scope: :buffet_admin

    visit buffet_path(buffet)
    click_on event.name
    click_on 'Adicionar Preço'
    within('#new_event_price') do
      fill_in 'Preço Inicial', with: '2750'
      fill_in 'Taxa por convidado extra', with: '75'
      fill_in 'Taxa por hora extra', with: '80'
      check 'Preço de Final de Semana'
      click_on 'Criar Preço'
    end

    expect(current_path).to eq event_type_path(event)
    expect(page).to have_content 'Preço cadastrado com sucesso!'
    expect(page).to have_content 'Preço Inicial: R$ 2.000,00'
    expect(page).to have_content 'R$ 50,00 por convidado extra'
    expect(page).to have_content 'R$ 25,00 por hora extra'
    expect(page).to have_content 'Preço Inicial: R$ 2.750,00'
    expect(page).to have_content 'R$ 75,00 por convidado extra'
    expect(page).to have_content 'R$ 80,00 por hora extra'
  end

  it "cant add a third" do
    admin = BuffetAdmin.create!(
      name: 'Admin 1 do Buffet',
      email: 'admin1@buffet.com',
      password: 'buff3t'
    )
    buffet = Buffet.create!(
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
      buffet_admin: admin
    )
    options = [
      EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
      EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
      EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
    ]
    event = EventType.create!(
      name: 'Tipo de Evento',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: buffet
    )
    weekday_price = EventPrice.create!(
      min_price: 2000,
      extra_guest_fee: 50,
      overtime_fee: 25,
      weekend_schedule: false,
      event_type: event
    )
    weekend_price = EventPrice.create!(
      min_price: 2000,
      extra_guest_fee: 50,
      overtime_fee: 25,
      weekend_schedule: true,
      event_type: event
    )
    login_as admin, scope: :buffet_admin

    visit new_event_price_path(event: event.id)
    within('#new_event_price') do
      fill_in 'Preço Inicial', with: '2750'
      fill_in 'Taxa por convidado extra', with: '75'
      fill_in 'Taxa por hora extra', with: '80'
      check 'Preço de Final de Semana'
      click_on 'Criar Preço'
    end
    
    expect(current_path).to eq event_prices_path
    expect(page).to have_content 'Preço não foi cadastrado!'
    expect(page).to have_field 'Preço Inicial', with: '2750'
    expect(page).to have_field 'Taxa por convidado extra', with: '75'
    expect(page).to have_field 'Taxa por hora extra', with: '80'
  end

end
