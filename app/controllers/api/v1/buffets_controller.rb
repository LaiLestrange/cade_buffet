class Api::V1::BuffetsController < Api::V1::ApiController
  def index
    buffets = Buffet.all
    render status: :ok, json: buffets.as_json(except: %i[created_at updated_at])
  end

  def show
    buffet = Buffet.find(params[:id])
    render status: :ok, json: {
      buffet: buffet.as_json(except: %i[registration_number brand_name created_at updated_at]),
      event_types: buffet.event_types.as_json(except: %i[created_at updated_at event_price_id])
    }
  end

  def search
    buffets = Buffet.where('brand_name like ?', "%#{params[:query]}%")
    if buffets.present?
      render status: :ok, json: buffets.as_json(except: %i[created_at updated_at])
    else
      msg = "Não há buffet com #{params[:query]} no nome"
      render status: :ok, json: { errors: msg }
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

    if orders.where(event_date: date).present?
      render status: :ok, json: {
        availability: 'O Buffet não está disponível para realizar eventos nesta data',
        available: false
      }
    elsif guests >= event.min_guests && guests <= event.max_guests
      render status: :ok, json: {
        availability: 'O Buffet está disponível para realizar esse evento',
        available: true,
        base_price: set_base_price(event, date, guests)
      }
    else
      if guests < event.min_guests
        render status: :ok, json: {
          availability: 'A quantidade mínima de convidados para esse evento não foi atingida',
          available: false
        }
      end
      if guests > event.max_guests
        render status: :ok, json: {
          availability: 'A quantidade máxima de convidados para esse evento foi excedida',
          available: false
        }
      end
    end
  end

  private

  def set_base_price(event, date, guests)
    date = Date.parse date
    price = if event.event_prices.present? && event.event_prices.count == 1
              event.event_prices.first
            elsif date.on_weekend?
              event.event_prices.where(weekend_schedule: true).first
            else
              event.event_prices.where(weekend_schedule: false).first
            end

    base_price = price.min_price # if price.present?

    if guests > event.max_guests
      extra_guests = guests - event.max_guests
      base_price += extra_guests * price.extra_guest_fee
    end

    base_price
  end
end
