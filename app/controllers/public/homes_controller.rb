class Public::HomesController < ApplicationController
  def top

    @cart_item = CartItem.new
    @genre = Genre.all
    @items = Item.order('id DESC').limit(4)
  end
end
