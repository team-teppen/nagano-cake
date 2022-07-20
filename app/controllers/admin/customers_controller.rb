class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page])
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end  
  
  def update
    if @customer = Customer.find(params[:id])
      @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end
  
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :last_name_kana, :first_name, :first_name_kana, :postal_code, :address, :phone_number, :email, :is_deleted)  
  end
  
end
