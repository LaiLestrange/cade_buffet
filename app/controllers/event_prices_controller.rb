class EventPricesController < ApplicationController
  before_action :authenticate_buffet_admin!
  before_action :get_event, only: [:new, :create]

  def new
    @price = EventPrice.new
  end

  def create

    @price = EventPrice.new(price_params)
    @price.event_type = @event

    if @price.save()
      redirect_to buffet_event_type_path(@event, @buffet), notice: 'Preço cadastrado com sucesso!'
    else
      flash.now[:notice] = "Preço não foi cadastrado!"
      render 'new'
    end
  end


  private
  def get_event
    @event = EventType.find(params[:event])
    @buffet = @event.buffet
  end

  def price_params
    params.require(:event_price).permit(
      :min_price,
      :extra_guest_fee,
      :overtime_fee,
      :weekend_schedule
    )
  end


end
