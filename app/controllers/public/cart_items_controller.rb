class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @total = 0
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    #一応記述
    @cart_item.customer_id = current_customer.id

      #カート内に同じ商品が存在しているかfind_byで確認
    if CartItem.find_by(item_id: cart_item_params[:item_id])
      #item_idが送られてきたitem_idと一致しているレコードを取得して変数に代入
      @cart_item = CartItem.find_by(item_id: cart_item_params[:item_id])
      #レコードのamountと送られてきたamountを足す
      @cart_item.amount += cart_item_params[:amount].to_i
      @cart_item.save
      flash[:notice] = "数量を変更しました"
    else
      #カート内に同じ商品が存在していなければ保存
      flash[:notice] = "カートに:#{@cart_item.item.name}を追加しました"
      @cart_item.save
    end
    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    flash[:notice] = "数量を#{@cart_item.amount}に変更しました"
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def all_destroy
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
