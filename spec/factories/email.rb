FactoryBot.define do
  sequence :seq_email do |n|
    "email#{n}@email.com"
  end
end
