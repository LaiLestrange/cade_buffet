class InvoicesController < ApplicationController
  before_action :get_base_price, only:[:new, :create]

  def new
    @order = Order.find(params[:order_id])
    @event = @order.event_type
    @buffet = @order.buffet
    @payment_methods = @buffet.payment_methods
    @invoice = Invoice.new(base_price: @base_price)
  end
  def create
    # @order = Order.find(params[:order_id])
    # @event = @order.event_type
    # @buffet = @order.buffet
    # @payment_methods = @buffet.payment_methods
    # @invoice = Invoice.new(base_price: @base_price)
  end

  private
  def get_base_price
    @base_price = 10
  end
end
