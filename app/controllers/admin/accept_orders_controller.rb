class Admin::AcceptOrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
  end
  
  def update
  end
  
      private
    
  def order_params
    params.require(:order).permit(:last_name, :first_name, :created_at, :address, :payment_method, :status)
  end
  
end
