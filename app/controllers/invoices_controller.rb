class InvoicesController < ApplicationController
  # before_action :get_base_price, only:[:new, :create]
  before_action :info_extractor, only:[:new, :create]

  def new
    @invoice = Invoice.new(order_id: params[:order_id])
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to @order, notice: "Proposta enviada com sucesso!"
    else
      flash.now[:notice] = "Proposta não cadastrada!"
      render 'new'
    end
  end

  private
  def info_extractor
    @order = Order.find(params[:order_id])
    @event = @order.event_type
    @buffet = @order.buffet
    @payment_methods = @buffet.payment_methods
  end

  def invoice_params
    invoice_params = params.require(:invoice).permit(
      :discount,
      :increase,
      :description,
      :expiration_date,
      payment_method_ids: []
    )
    invoice_params[:order_id] = params[:order_id]
    invoice_params
  end
end
