class EventTypesController < ApplicationController
  before_action :authenticate_buffet_admin!
  before_action :get_options, only: [:new, :create]
  def new
    @event = EventType.new
  end

  def create
    buffet_id = current_buffet_admin.buffet.id

    @event = EventType.new(event_params)
    if @event.save()
      redirect_to buffet_path(buffet_id), notice: 'Evento cadastrado com sucesso!'
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
      event_option_ids: [],
    )
  end

  def get_options
    @options = EventOption.all
  end
end
