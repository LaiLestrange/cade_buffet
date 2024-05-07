class OrdersController < ApplicationController
before_action :authenticate_customer!, only: [:new, :create, :show, :index]
before_action :order_params, only: [:create]
  def new
    @order = Order.new
    buffet_id = params[:buffet_id]
    event_type_id = params[:event_type_id]

    unless Buffet.where(id: buffet_id).present?
      return redirect_to root_path, notice: "Escolha um Buffet! #{params}"
    end

    unless EventType.where(id: event_type_id).present?
      @events = Buffet.find(buffet_id).event_types
      render 'new_event_type'
    else
      @buffet = Buffet.find(buffet_id)
      @event = EventType.find(event_type_id)
      @order.address = @buffet.address
    end
  end

  def create
    @order = Order.new(order_params)

    @buffet = Buffet.find(params[:buffet_id])
    @event = EventType.find(params[:event_type_id])

    @events = @buffet.event_types
    @order.customer = current_customer
    @order.buffet = @buffet
    @order.event_type = @event
    @order.address = @buffet.address unless @event.location
    @order.address = @buffet.address if @order.address.empty?
    if @order.save
      redirect_to order_path(@order), notice: 'Pedido enviado com sucesso!'
    else
      flash.now[:notice] = "Pedido não cadastrado!"
      render 'new'
    end

  end

  def show
    @order = Order.find(params[:id])
    if customer_signed_in?
      unless current_customer.orders.include?(@order)
        redirect_to orders_path, notice: 'Acesse os seus pedidos'
      end
    end
  end

  def index
    @orders = Order.where(customer: current_customer)
  end

  private
  def order_params
    params.require(:order).permit(
      :event_date,
      :guests,
      :address,
      :more_details,
      # :event_type_id
      )
  end

end
