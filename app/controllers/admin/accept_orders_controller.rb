class Admin::AcceptOrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @total = @order.order_details.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
  end
  
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    # 注文ステータスが入金確認⇨製作ステータス着手不可から製作待ちに変わる。
    if params[:order][:status] == "paid_up"
      OrderDetail.where(order_id: @order.id).update_all(making_status: 1)
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
