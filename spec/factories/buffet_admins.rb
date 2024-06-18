FactoryBot.define do
  factory :buffet_admin do
    name { 'Administrador de Buffet' }
    email { generate :seq_email }
    password { 'buffetadmin' }
  end
end
