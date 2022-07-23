class ApplicationController < ActionController::Base
  

  def after_sign_up_path_for(resource)
    my_page_path
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      admin_root_path
    elsif resource == :customer
      root_path
    end
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number])
    end


end
