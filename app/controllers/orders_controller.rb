class OrdersController < ApplicationController
before_action :authenticate_customer!, only: [:new, :create, :show, :index]
before_action :order_params, only: [:create]
  def new
    @order = Order.new
    buffet_id = params[:buffet_id]
    unless Buffet.where(id: buffet_id).present?
      return redirect_to root_path, notice: "Escolha um Buffet!"
    end
    @buffet = Buffet.find(buffet_id)
    @events = @buffet.event_types
  end

  def create
    @order = Order.new(order_params)

    event = @order.event_type
    buffet = event.buffet

    @events = buffet.event_types
    @order.customer = current_customer
    @order.buffet = buffet
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
      :event_type_id
      )
  end
end
