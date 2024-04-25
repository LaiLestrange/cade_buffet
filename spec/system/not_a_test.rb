require 'rails_helper'

describe "Situações de Implementação" do
  context "1x" do
    it "Completo" do
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

      puts "\n\n"
      puts "**********"
      puts "\n**\tOptions: "
      puts options.map { |option| JSON.pretty_generate(option.attributes).gsub(":", " =>")}
      puts "\n**\tAdmin: "
      puts JSON.pretty_generate(admin.attributes).gsub(":", " =>")
      puts "\n**\tBuffet: "
      puts JSON.pretty_generate(buffet.attributes).gsub(":", " =>")
      puts "\n**\tEvent: "
      puts JSON.pretty_generate(event.attributes).gsub(":", " =>")
      puts "\n**\tWeekend_price: "
      puts JSON.pretty_generate(weekend_price.attributes).gsub(":", " =>")
      puts "\n**\tWeekday_price: "
      puts JSON.pretty_generate(weekday_price.attributes).gsub(":", " =>")
      puts "\n**\tPayment_method: "
      puts JSON.pretty_generate(payment_method.attributes).gsub(":", " =>")
      puts "**********"
      puts "\n\n\n\n\n"

    end
  end
end
