class HomeController < ApplicationController

  def index
    if buffet_admin_signed_in?
      return redirect_to buffet_path(current_buffet_admin.buffet) if current_buffet_admin.buffet.present?
      @buffets = Buffet.all
    else
      @buffets = Buffet.all
    end
  end
  def search
    buffets = Buffet.where('brand_name like ? OR city like ?', "%#{params[:q]}%", "%#{params[:q]}%")
    events = EventType.where('name like ?', "%#{params[:q]}%")
    buffets_ids = buffets.map(&:id) + events.map{|event| event.buffet.id}
    @buffets = Buffet.where(id: buffets_ids).sort_by(&:brand_name)
  end
end
