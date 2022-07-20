class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.order(created_at: :desc).where(is_active: "販売可").page(params[:page]).per(8)
    else
      @items = Item.where(is_active: "販売可").page(params[:page]).per(12)
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genre = Genre.all
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :is_active, :genre_id)
  end

end
