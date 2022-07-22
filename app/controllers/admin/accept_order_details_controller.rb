class Admin::AcceptOrderDetailsController < ApplicationController
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    # 製作ステータスのどれかが製作中になったら、注文ステータスも製作中になる
    if params[:order_detail][:making_status] == "manufacturing"
      Order.find_by(id: @order_detail.order_id).update(status: 2)
    elsif params[:order_detail][:making_status] == "finish"
    # 全て製作完了になったら注文ステータスが発送準備中に変わる
      if OrderDetail.where(order_id: @order_detail.order_id).where.not(making_status: 3).exists? != true
        Order.find_by(id: @order_detail.order_id).update(status: 3)
      end
    end
    redirect_to admin_accept_order_path(@order_detail.order.id)
  end
  
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
  
end
