class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :admin_has_buffet

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def admin_has_buffet
    missing_buffet = buffet_admin_signed_in? && current_buffet_admin.buffet_id.nil?
    current_path = url_for(only_path: true)

    if missing_buffet
      unless current_path == new_buffet_path || current_path == destroy_buffet_admin_session_path || current_path == buffets_path
        @buffet = Buffet.new
        redirect_to new_buffet_path, notice: 'Cadastre seu Buffet'
      end
    else
      if buffet_admin_signed_in?
        @buffet = Buffet.find(current_buffet_admin.buffet_id)
        if current_path == new_buffet_path
          redirect_to root_path, notice: 'Já possui um Buffet cadastrado!'
        end
        if current_path == edit_buffet_path && current_path != edit_buffet_path(@buffet)
          redirect_to edit_buffet_path(@buffet), notice: 'Edite o seu Buffet'
        end
        if current_path == buffet_path && current_path != buffet_path(@buffet)
          redirect_to buffet_path(@buffet)
        end
      end
    end
  end
end
