class BuffetsController < ApplicationController
  before_action :authenticate_buffet_admin!, only: [:show, :edit, :update, :new, :create]

  def index
    if buffet_admin_signed_in? && current_buffet_admin.buffet.blank?
      @buffet = Buffet.new
      redirect_to new_buffet_path, notice: "Cadastre seu Buffet"
    end
  end
  def show
    @buffet = current_buffet_admin.buffet
    @events = EventType.where(buffet: @buffet)
    if params[:id].to_i != @buffet.id
      redirect_to buffet_path(@buffet), notice: 'Veja o seu Buffet'
    end
  end
  def new
    @buffet = Buffet.new
    @buffet.buffet_admin = current_buffet_admin
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.buffet_admin = current_buffet_admin
    if @buffet.save
      current_buffet_admin.update(buffet: @buffet)
      redirect_to buffet_path(@buffet), notice: "Buffet cadastrado com sucesso!"
    else
      redirect_to new_buffet_path, notice: "Cadastre seu Buffet"
    end
  end

  def edit
    @buffet = current_buffet_admin.buffet
    if params[:id].to_i != @buffet.id
      redirect_to edit_buffet_path(@buffet), notice: 'Edite o seu Buffet'
    end
  end

  def update
    if @buffet.update(buffet_params)
      redirect_to buffet_path(@buffet), notice: "Buffet atualizado com sucesso!"
    else
      flash.now[:notice] = "Não foi possível atualizar o Buffet!"
      render 'edit'
    end

  end

  private
  def buffet_params
    params.require(:buffet).permit(
      :brand_name,
      :company_name,
      :registration_number,
      :phone_number,
      :email,
      :full_address,
      :state,
      :city,
      :zip_code,
      :description
      #, :payment_methods
    )
  end
end
