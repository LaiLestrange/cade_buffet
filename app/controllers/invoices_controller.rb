class InvoicesController < ApplicationController

  def new
    @order = Order.find(params[:order_id])
    @event = @order.event_type

  end

end
