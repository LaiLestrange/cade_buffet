class InvoicesController < ApplicationController
  # before_action :get_base_price, only:[:new, :create]
  before_action :info_extractor, only:[:new, :create]

  def new
    @invoice = Invoice.new(base_price: base_price)
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.order = @order
    @invoice.base_price = base_price
    @invoice.final_price = final_price
    if @invoice.save
      @order.approved!
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
    params.require(:invoice).permit(
      :discount,
      :increase,
      :description,
      :expiration_date,
      payment_method_ids: []
    )
  end

  def base_price
    if @event.present? && @event.event_prices.count == 1
      price = @event.event_prices.first
    else
      if @order.event_date.on_weekend?
        price = @event.event_prices.where(weekend_schedule: true).first
      else
        price = @event.event_prices.where(weekend_schedule: false).first
      end
    end

    @base_price = price.min_price

    if @order.guests > @event.max_guests
      extra_guests = @order.guests - @event.max_guests
      @base_price += extra_guests * price.extra_guest_fee
    end

    @base_price
  end

  def final_price
    final_price = base_price
    if @invoice.discount.present?
      discount_value = final_price * (@invoice.discount / 100)
      final_price -= discount_value
    end

    if @invoice.increase.present?
      increase_value = final_price * (@invoice.increase / 100)
      final_price += increase_value
    end

    final_price
  end

end
