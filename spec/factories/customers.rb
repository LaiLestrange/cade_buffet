FactoryBot.define do
  factory :customer do
    name { 'Cliente' }
    social_security_number { '27055288061' }
    email { generate :seq_email }
    password { 'cliente' }
  end
end
