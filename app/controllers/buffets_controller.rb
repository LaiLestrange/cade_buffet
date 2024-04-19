class BuffetsController < ApplicationController
  before_action :authenticate_buffet_admin!, only: [:create]
  # before_action :authenticate_buffet_admin!, only: [:new, :create, :edit, :update]

  def index

  end
  def new
    @buffet = Buffet.new
  end
  def create
    @buffet = Buffet.new(buffet_params)
    @buffet.buffet_admin_id = current_buffet_admin.id
    if @buffet.save
      redirect_to buffets_path, notice: "Buffet cadastrado com sucesso!"
    else
      flash.now[:notice] = "Buffet não cadastrado!"
      redirect_to root_path
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
