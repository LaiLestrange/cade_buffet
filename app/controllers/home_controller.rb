class HomeController < ApplicationController
  # before_action :authenticate_buffet_admin
  def index
    @is_buffet_admin = buffet_admin_signed_in?
    @buffet = Buffet.new
    if @is_buffet_admin
      @registered_buffet = Buffet.where(buffet_admin_id: current_buffet_admin.id)
    else
    end
  end
end
