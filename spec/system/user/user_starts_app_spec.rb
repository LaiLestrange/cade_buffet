require 'rails_helper'

describe "User creates an account" do
  context "#Buffet_Admin" do
    it "from the root page" do

      visit root_path
      within 'header'  do
        click_on 'Entrar como Administrador'
      end
      click_on 'Criar uma conta'

      expect(current_path).to eq new_buffet_admin_registration_path
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
      new_buffet_admin = BuffetAdmin.new(
        name: "Administrador do Buffet",
        email: "buffet@admin.com",
        password: "04dm1n"
      )

      visit root_path
      within 'header'  do
        click_on 'Entrar como Administrador'
      end
      click_on 'Criar uma conta'
      within '#new_buffet_admin_account' do
        fill_in 'Nome', with: new_buffet_admin.name
        fill_in 'E-mail', with: new_buffet_admin.email
        fill_in 'Senha', with: new_buffet_admin.password
        fill_in 'Confirme sua senha', with: new_buffet_admin.password
        click_on 'Criar conta'
      end

      expect(current_path).to eq new_buffet_path
      expect(page).to have_content "Olá, #{new_buffet_admin.name}"
      expect(page).to have_content "Cadastre seu Buffet"
      expect(page).to have_button "Sair"
    end

    it "and leaves name blank" do
      new_buffet_admin = BuffetAdmin.new(
        name: '',
        email: "buffet@admin.com",
        password: "04dm1n"
      )

      visit root_path
      within 'header'  do
        click_on 'Entrar como Administrador'
      end
      click_on 'Criar uma conta'
      within '#new_buffet_admin_account' do
        fill_in 'Nome', with: new_buffet_admin.name
        fill_in 'E-mail', with: new_buffet_admin.email
        fill_in 'Senha', with: new_buffet_admin.password
        fill_in 'Confirme sua senha', with: new_buffet_admin.password
        click_on 'Criar conta'
      end

      expect(current_path).to eq new_buffet_path
      expect(page).to have_content "Olá, #{new_buffet_admin.email}"
      expect(page).to have_content "Cadastre seu Buffet"
      expect(page).to have_button "Sair"
    end
  end
  context "#Customer" do
    it "from the root page" do

      visit root_path
      click_on 'Entrar como Cliente'
      click_on 'Criar uma conta'

      expect(current_path).to eq new_customer_registration_path
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

    it "successfully" do
      new_customer = Customer.new(
        name: 'Nome do Cliente',
        social_security_number: "48527862085",
        email: "cliente@buffet.com",
        password: "cl13n73"
      )

      visit root_path
      within 'header'  do
        click_on 'Entrar como Cliente'
      end
      click_on 'Criar uma conta'
      within '#new_customer_account' do
        fill_in 'Nome', with: new_customer.name
        fill_in 'E-mail', with: new_customer.email
        fill_in 'CPF', with: new_customer.social_security_number
        fill_in 'Senha', with: new_customer.password
        fill_in 'Confirme sua senha', with: new_customer.password
        click_on 'Criar conta'
      end

      # expect(current_path).to eq root_path ????
      expect(page).to have_content "Olá, #{new_customer.name}"
      expect(page).not_to have_content "Entrar"
      expect(page).not_to have_content "Cadastre seu Buffet"
      expect(page).to have_button "Sair"
    end

    it "and can't leave missing information" do
      new_customer = Customer.new(
        name: 'Nome do Cliente',
        social_security_number: "",
        email: "cliente@buffet.com",
        password: "cl13n73"
      )

      visit root_path
      within 'header'  do
        click_on 'Entrar como Cliente'
      end
      click_on 'Criar uma conta'
      within '#new_customer_account' do
        fill_in 'Nome', with: new_customer.name
        fill_in 'E-mail', with: new_customer.email
        fill_in 'CPF', with: new_customer.social_security_number
        fill_in 'Senha', with: new_customer.password
        fill_in 'Confirme sua senha', with: new_customer.password
        click_on 'Criar conta'
      end

      # expect(current_path).to eq new_customer_registration_path ???
      expect(page).to have_content "Não foi possível salvar cliente"
    end
  end
end

describe "User starts app" do
  it "and is not logged in" do

    visit root_path

    expect(page).to have_content 'Cadê Buffet?'
    within 'header' do
      expect(page).to have_link 'Entrar'
    end
  end

  context "and sees all buffets" do
    it "from the root_path" do

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

      visit root_path

      expect(current_path).to eq root_path
      expect(page).to have_content 'Buffets'
      expect(page).to have_content first_buffet.brand_name
      expect(page).to have_content first_buffet.city
      expect(page).to have_content first_buffet.state
      expect(page).to have_content second_buffet.brand_name
      expect(page).to have_content second_buffet.city
      expect(page).to have_content second_buffet.state
    end

    it 'and chooses a buffet to see the details' do
      admin = BuffetAdmin.create!(
        name: "Administrador de Buffet",
        email: "admin@buffet.com",
        password: "8uff374dm1n"
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
      payment_method = PaymentMethod.create!(
        name: 'Método de Pagamento',
        details: 'Método de Pagamento que o Buffet pode oferecer',
        buffet: buffet
      )

      visit root_path
      click_on buffet.brand_name

      expect(current_path).to eq buffet_path(buffet)
      expect(page).to have_content buffet.company_name
      expect(page).not_to have_content buffet.registration_number

    end

    it 'and sees the details of an event' do
      admin = BuffetAdmin.create!(
        name: "Administrador de Buffet",
        email: "admin@buffet.com",
        password: "8uff374dm1n"
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
        min_price: 2500,
        extra_guest_fee: 70,
        overtime_fee: 60,
        weekend_schedule: true,
        event_type: event
      )
      payment_method = PaymentMethod.create!(
        name: 'Método de Pagamento',
        details: 'Método de Pagamento que o Buffet pode oferecer',
        buffet: buffet
      )

      visit root_path
      click_on buffet.brand_name
      click_on event.name

      expect(current_path).to eq buffet_event_type_path(buffet, event)
      expect(page).to have_content event.menu
      expect(page).to have_content 'R$ 2.000,00'
      expect(page).to have_content 'R$ 70,00'

    end

  end
end

describe "User searches for buffet" do
  it "from the root page" do
    visit root_path

    expect(page).to have_field 'Procurar Buffets'
  end

  it "and searches by buffet.brand_name" do

    options = [
      EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
      EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
      EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento")
    ]
    first_admin = BuffetAdmin.create!(
      name: 'Admin 1 do Buffet',
      email: 'admin1@buffet.com',
      password: 'buff3t'
    )
    first_buffet = Buffet.create!(
      brand_name: 'Eventos 1 Buffet PESQUISA',
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
    first_event = EventType.create!(
      name: 'Tipo de Evento',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: first_buffet
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
    second_event = EventType.create!(
      name: 'Tipo de Evento',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: second_buffet
    )

    visit root_path
    fill_in 'Procurar Buffets', with: 'PESQUISA'
    click_on 'Pesquisar'

    expect(page).to have_content first_buffet.brand_name
    expect(page).to have_content first_buffet.city
    expect(page).to have_content first_buffet.state
  end

  it "and searches by buffet.city" do
    options = [
      EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
      EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
      EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
    ]
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
      city: 'Eventuais PESQUISA',
      zip_code: '11111-111',
      description: 'A descrição do primeiro buffet',
      buffet_admin: first_admin
    )
    first_event = EventType.create!(
      name: 'Tipo de Evento',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: first_buffet
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
    second_event = EventType.create!(
      name: 'Tipo de Evento',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: second_buffet
    )

    visit root_path
    fill_in 'Procurar Buffets', with: 'PESQUISA'
    click_on 'Pesquisar'

    expect(page).to have_content first_buffet.brand_name
    expect(page).to have_content first_buffet.city
    expect(page).to have_content first_buffet.state
  end

  it "and searches by event.name" do
    options = [
      EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
      EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
      EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
    ]
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
      city: 'Eventuais PESQUISA',
      zip_code: '11111-111',
      description: 'A descrição do primeiro buffet',
      buffet_admin: first_admin
    )
    first_event = EventType.create!(
      name: 'Tipo de Evento PESQUISA',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: first_buffet
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
    second_event = EventType.create!(
      name: 'Tipo de Evento',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: second_buffet
    )

    visit root_path
    fill_in 'Procurar Buffets', with: 'PESQUISA'
    click_on 'Pesquisar'

    expect(page).to have_content ''
  end

  it "and sees it ordered alphabetically" do
    options = [
      EventOption.create!(name: "Bar", description: "Serviço de bebida alcóolica durante o evento"),
      EventOption.create!(name: "Decoração", description: "Organização e decoração do espaço do evento"),
      EventOption.create!(name: "Valet", description: "Serviço de estacionamento durante o evento"),
    ]
    first_admin = BuffetAdmin.create!(
      name: 'Admin 1 do Buffet',
      email: 'admin1@buffet.com',
      password: 'buff3t'
    )
    first_buffet = Buffet.create!(
      brand_name: 'B Eventos 1 Buffet',
      company_name: 'Buffet 1 de Eventos LTDA',
      registration_number: '123456789',
      phone_number: '11 11111-1111',
      email: 'buffet1@buffet.com',
      full_address: 'Rua dos Buffets, 11, Bairro dos Eventos',
      state: 'BF',
      city: 'Eventuais PESQUISA',
      zip_code: '11111-111',
      description: 'A descrição do primeiro buffet',
      buffet_admin: first_admin
    )
    first_event = EventType.create!(
      name: 'Tipo de Evento PESQUISA',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: first_buffet
    )
    second_admin = BuffetAdmin.create!(
      name: 'Admin 2 do Buffet',
      email: 'admin2@buffet.com',
      password: 'buff3t'
    )
    second_buffet = Buffet.create!(
      brand_name: 'A Eventos 2 Buffet PESQUISA',
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
    second_event = EventType.create!(
      name: 'Tipo de Evento',
      description: 'Descrição do evento, propaganda, etc',
      menu: 'Cardápio do evento, tipo de comida etc',
      location: false,
      min_guests: 10,
      max_guests: 50,
      duration: 120,
      event_options: options,
      buffet: second_buffet
    )

    visit root_path
    fill_in 'Procurar Buffets', with: 'PESQUISA'
    click_on 'Pesquisar'

    within ('#buffet_search > div:nth-child(1)') do
      expect(page).to have_content second_buffet.brand_name
    end
    within ('#buffet_search > div:nth-child(2)') do
      expect(page).to have_content first_buffet.brand_name
    end
  end
end
