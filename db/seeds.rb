# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

  # EventOption.create!( name: "SEED Bar",
  #                      description: "SEED Serviço de bebida alcóolica durante o evento")
  # EventOption.create!( name: "SEED Decoração",
  #                      description: "SEED Organização e decoração do espaço do evento" )
  # EventOption.create!( name: "SEED Valet",
  #                     description: "SEED Serviço de estacionamento durante o evento")

  # PaymentMethod.create!( name: "SEED Pix",
  #                        details: "Chave pix: 548465456487")
  # PaymentMethod.create!( name: "SEED Cartão de Crédito",
  #                        details: "Em até 12x sem juros")
  # PaymentMethod.create!( name: "SEED Cartão de Débito",
  #                        details: "Descontos de até 5%")
  # PaymentMethod.create!( name: "SEED Dinheiro",
  #                        details: "Descontos de até 10%")

  # first_admin = BuffetAdmin.create!(
  #   name: 'SEED Admin 1 do Buffet',
  #   email: 'SEED admin1@buffet.com',
  #   password: 'buff3t',
  #   buffet: Buffet.create!(
  #   brand_name: 'SEED Eventos 1 Buffet',
  #   company_name: 'SEED Buffet 1 de Eventos LTDA',
  #   registration_number: '123456789',
  #   phone_number: '11 11111-1111',
  #   email: 'buffet1@buffet.com',
  #   full_address: 'SEED Rua dos Buffets, 11, Bairro dos Eventos',
  #   state: 'BF',
  #   city: 'SEED Eventuais',
  #   zip_code: '11111-111',
  #   description: 'SEED A descrição do primeiro buffet',
  #   # payment_methods: 'Pix, Cartão de Crédito, Dinheiro',
  #   buffet_admin: first_admin))

  # second_admin = BuffetAdmin.create!(
  #   name: 'SEED Admin 2 do Buffet',
  #   email: 'SEED admin2@buffet.com',
  #   password: 'buff3t',
  #   buffet: Buffet.create!(
  #   brand_name: 'SEED Eventos 2 Buffet',
  #   company_name: 'SEED Buffet 2 de Eventos LTDA',
  #   registration_number: '234567891',
  #   phone_number: '22 22222-2222',
  #   email: 'buffet2@buffet.com',
  #   full_address: 'SEED Rua dos Buffets, 12, Bairro dos Eventos',
  #   state: 'BF',
  #   city: 'SEED Eventuais',
  #   zip_code: '22222-222',
  #   description: 'SEED A descrição do secundo buffet',
  #   # payment_methods: 'Pix, Dinheiro',
  #   buffet_admin: second_admin))
