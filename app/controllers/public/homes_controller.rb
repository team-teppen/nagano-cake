class Public::HomesController < ApplicationController
  def top
    @cart_item = CartItem.new
  end
end
