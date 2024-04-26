# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

  EventOption.create!(
    name: "SEED Bar",
    description: "SEED Serviço de bebida alcóolica durante o evento"
    )
  EventOption.create!(
    name: "SEED Decoração",
    description: "SEED Organização e decoração do espaço do evento"
    )
  EventOption.create!(
    name: "SEED Valet",
    description: "SEED Serviço de estacionamento durante o evento"
    )
seed_admin =  BuffetAdmin.create!(
  name: "SEEDAdministrador de Buffet",
  email: "SEED@buffet.com",
  password: "8uff374dm1n"
  )
seed_buffet = Buffet.create!(
  brand_name: 'SEED Eventos Buffet',
  company_name: 'SEED Buffet de Eventos LTDA',
  registration_number: '9999',
  phone_number: '11 1111-1111',
  email: 'eventos@buffet.com',
  full_address: 'Rua dos Eventos, 2',
  state: 'EV',
  city: 'Eventual',
  zip_code: '33333-333',
  description: 'Esse é um Buffet de Eventos',
  buffet_admin: seed_admin)
seed_event_1 = EventType.create!(
  name: 'SEED Tipo de Evento',
  description: 'SEED Descrição do evento, propaganda, etc',
  menu: 'SEED Cardápio do evento, tipo de comida etc',
  location: false,
  min_guests: 10,
  max_guests: 50,
  duration: 120,
  event_options: EventOption.all,
  buffet: seed_buffet)
seed_e1_weekday_price = EventPrice.create!(
  min_price: 2000,
  extra_guest_fee: 50,
  overtime_fee: 25,
  weekend_schedule: false,
  event_type: seed_event_1)
seed_e1_weekend_price = EventPrice.create!(
  min_price: 2000,
  extra_guest_fee: 50,
  overtime_fee: 25,
  weekend_schedule: true,
  event_type: seed_event_1)
seed_payment_method = PaymentMethod.create!(
  name: 'Método de Pagamento',
  details: 'Método de Pagamento que o Buffet pode oferecer',
  buffet: seed_buffet)
