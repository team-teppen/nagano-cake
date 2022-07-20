class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @total = 0
  end

  def create

    @item = Item.find(cart_item_params[:item_id])
    
    @cart_item = CartItem.new(cart_item_params)
  
    @cart_item.customer_id = current_customer.id

    #カート内に同じ商品があれば追加
    # if @cart_item.find_by(item_id: params[:item_id])
    #   @cart_item.find_by(item_id: cart_item_params[:item_id]).amount += params[:amount].to_i
    #   @cart_item.save
    #   redirect_to cart_items_path
    # else
    #   @cart_item.save
    # end

    @cart_item.save
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def all_destroy
    current_customer.cart_items.destroy_all
    redirect_back(fallback_location: root_path)
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
