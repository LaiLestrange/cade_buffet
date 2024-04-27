class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :admin_has_buffet
  before_action :is_customer

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :social_security_number])
  end

  def admin_has_buffet
    missing_buffet = buffet_admin_signed_in? && current_buffet_admin.buffet.nil?
    current_path = url_for(only_path: true)

    if missing_buffet
      unless current_path == new_buffet_path || current_path == destroy_buffet_admin_session_path || current_path == buffets_path
        @buffet = Buffet.new

        redirect_to new_buffet_path, notice: 'Cadastre seu Buffet'
      end
    else
      if buffet_admin_signed_in?
        @buffet = current_buffet_admin.buffet
        if current_path == new_buffet_path
          redirect_to root_path, notice: 'Já possui um Buffet cadastrado!'
        end
      end
    end
  end

  def is_customer
    current_path = url_for(only_path: true)
    if customer_signed_in?
      if current_path == new_customer_session_path || current_path == new_buffet_admin_session_path
        redirect_to root_path, notice: "Você não possui autorização para essa ação!"
      end
    end
  end
end
