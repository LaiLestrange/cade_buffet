class EventTypesController < ApplicationController
  before_action :authenticate_buffet_admin!, only: [:new, :create, :index]
  before_action :get_options, only: [:new, :create]
  def show
    id = params[:id]
    buffet = Buffet.find(params[:buffet_id])
    valid_request = buffet.event_type_ids.include?(id)
    unless valid_request
      @event = EventType.find(id)
      @prices = @event.event_prices
      if buffet_admin_signed_in?
        if !current_buffet_admin.buffet.event_types.ids.include?(id.to_i)
          return redirect_to buffet_path(current_buffet_admin.buffet), notice: "Não foi possível visualizar esse evento!"
        end
      end
    else
        return redirect_to buffet_path(buffet), notice: "Esse evento não pertence à esse Buffet"
    end
  end
  def new
    @event = EventType.new
    @buffet = current_buffet_admin.buffet
  end

  def create
    @buffet = current_buffet_admin.buffet

    @event = EventType.new(event_params)
    @event.buffet = @buffet
    if @event.save()
      redirect_to buffet_path(@buffet), notice: 'Evento cadastrado com sucesso!'
    else
      flash.now[:notice] = "Evento não cadastrado!"
      render 'new'
    end
  end

  private
  def event_params
    params.require(:event_type).permit(
      :name,
      :description,
      :menu,
      :location,
      :min_guests,
      :max_guests,
      :duration,
      photos: [],
      event_option_ids: []
    )
  end

  def get_options
    @options = EventOption.all
  end
end
