FactoryBot.define do
  factory :buffet do
    brand_name { 'Nome Fantasia Buffet' }
    company_name { 'Razão Social do Buffet LTDA' }
    registration_number { generate :seq_registration_number }
    phone_number { '11 1111-1111' }
    email { generate :seq_email }
    full_address { 'Rua dos Eventos, 1' }
    state { 'EV' }
    city { 'Eventual' }
    zip_code { '33333-333' }
    description { 'Esse é um Buffet de Eventos' }
    buffet_admin
  end
end
