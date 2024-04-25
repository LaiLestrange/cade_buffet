class HomeController < ApplicationController

  def index
    if buffet_admin_signed_in?
      redirect_to buffet_path(current_buffet_admin.buffet)
    else
      @buffets = Buffet.all
    end
  end


end
