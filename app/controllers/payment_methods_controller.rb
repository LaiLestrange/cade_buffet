class PaymentMethodsController < ApplicationController
  before_action :authenticate_buffet_admin!, only: [:new, :create]
  def new
    @payment_method = PaymentMethod.new
    @buffet = current_buffet_admin.buffet
  end

  def create
    @payment_method = PaymentMethod.new(payment_methods_params)
    @buffet = current_buffet_admin.buffet
    @payment_method.buffet = @buffet

    if @payment_method.save
      redirect_to new_payment_method_path, notice: "Método de Pagamento cadastrado com sucesso!"
    else
      flash.now[:notice] = "Método de Pagamento não foi cadastrado!"
      render 'new'
    end
  end

  private
  def payment_methods_params
    params.require(:payment_method).permit(
      :name,
      :details
    )
  end
end
