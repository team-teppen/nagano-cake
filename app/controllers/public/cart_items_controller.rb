class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @total = 0
  end

  def create
    @cart_item = CartItem.new(cart_items_params)
    @cart_item.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @cart_item = CartItem.find_by(item_id: cart_item_params[:item_id])
    @cart_item.destroy
    redirect_back(fallback_location: root_path)
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
