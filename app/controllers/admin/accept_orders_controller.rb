class Admin::AcceptOrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.all
    @total = @order_detail.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
    
  end
  
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if params[:order][:status] == "1"
      @order_detail.all, params[:order_detai][:making_status] = "1"
    end
    redirect_back(fallback_location: root_path)
  end
    
  
      private
    
  def order_params
    params.require(:order).permit(:last_name, :first_name, :created_at, :address, :payment_method, :status, )
  end
  
  
  def order_detail_params
    params.require(:order_details).permit(:name, :price, :amount, :making_status, :shipping_cost)
  end
end
