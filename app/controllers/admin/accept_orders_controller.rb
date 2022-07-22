class Admin::AcceptOrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @total = @order.order_details.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
    
  end
  
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    # 注文ステータスが入金確認⇨製作ステータス着手不可から製作待ちに変わる。
    @order_detail = OrderDetail.where(order_id: @order.id)
    if params[:order][:status] == 1
      @order_detail.each do |order_detail|
        order_detail.making_status = 1
        @order_detail.making_status = order_detail.making_status
        @order_detail.update
      end
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
