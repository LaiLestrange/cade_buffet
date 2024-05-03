class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :starting_app

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :social_security_number])
  end

  def starting_app
    @buffet_admin_app = buffet_admin_signed_in?
    @customer_app = customer_signed_in?
    @user_app = !@buffet_admin_app && !@customer_app
    current_path = request.fullpath

    # app = "user" if @user_app
    # app = "customer" if @customer_app
    # app = "buffet_admin" if @buffet_admin_app

    # puts "APP: #{app}"
    # puts "current_path: #{current_path}"

    if @buffet_admin_app
      buffet = current_buffet_admin.buffet
      unless buffet.present?
        if current_path == root_path
          redirect_to new_buffet_path, notice: "Cadastre seu Buffet"
        end
      end
    end

    if @customer_app
      if current_path == buffets_path
        return redirect_to root_path
      else
        if current_path == new_buffet_admin_session_path
          redirect_to root_path, notice: "Você não possui autorização para essa ação!"
        end
      end
    end

  end
end
