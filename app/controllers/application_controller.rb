class ApplicationController < ActionController::Base
  def after_sign_in_path(resource)
    items_path
  end
  
  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number])
    end
  
  
end
