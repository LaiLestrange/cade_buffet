class BuffetsController < ApplicationController
  before_action :authenticate_buffet_admin!, only: [:show, :edit, :update, :new, :create]

  def index
    if buffet_admin_signed_in? && current_buffet_admin.buffet.blank?
      @buffet = Buffet.new
      redirect_to new_buffet_path, notice: "Cadastre seu Buffet"
    end
  end
  def show
    @buffet = Buffet.find(params[:id])
  end
  def new
    @buffet = Buffet.new
  end

  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.buffet_admin_id = current_buffet_admin.id
    if @buffet.save
      current_buffet_admin.update(buffet_id: @buffet.id)
      redirect_to buffet_path(@buffet.id), notice: "Buffet cadastrado com sucesso!"
    else
      redirect_to new_buffet_path, notice: "Cadastre seu Buffet"
    end
  end

  def edit
    @buffet = Buffet.find(current_buffet_admin.buffet_id)
  end

  def update
    if @buffet.update(buffet_params)
      redirect_to buffet_path(@buffet.id), notice: "Buffet atualizado com sucesso!"
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
      )
  end
end
