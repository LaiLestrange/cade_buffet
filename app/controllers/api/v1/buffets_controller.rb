class Api::V1::BuffetsController < Api::V1::ApiController

  def show
    buffet = Buffet.find(params[:id])
    render status: 200, json: {
      buffet: buffet.as_json( except: [:registration_number, :brand_name, :created_at, :updated_at]),
      event_types: buffet.event_types.as_json( except: [:created_at, :updated_at])
    }
  end

  def index
    buffets = Buffet.all
    render status: 200, json: buffets
  end

  def search
    buffets = Buffet.where('brand_name like ?', "%#{params[:query]}%")
    if buffets.present?
      render status: 200, json: buffets
    else
      msg = "Não há buffet com #{params[:query]} no nome"
      render status: 200, json: {errors: msg}
    end
  end

  def availability
    event = EventType.find(params[:event_id])
    date = params[:date]
    guests = params[:guests].to_i

    orders = Order.where(buffet: event.buffet)
                  .where.not(status: :canceled)
                  .where.not(status: :expired)
                  .where.not(status: :done)


    unless orders.where(event_date: date).present?
      if guests >= event.min_guests && guests <= event.max_guests
        render status: 200, json: {
          availability: "O Buffet está disponível para realizar esse evento",
          available: true
        }
      else
        if guests < event.min_guests
          render status: 200, json: {
            availability: "A quantidade mínima de convidados para esse evento não foi atingida",
            available: false
          }
        end
        if guests > event.max_guests
          render status: 200, json: {
            availability: "A quantidade máxima de convidados para esse evento foi excedida",
            available: false
          }
        end
      end
    else
      render status: 200, json: {
        availability: "O Buffet não está disponível para realizar eventos nesta data",
        available: false
      }
    end

  end
end
