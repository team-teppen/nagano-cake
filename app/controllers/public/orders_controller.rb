class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    #↓注文情報入力(new.html.erb)ページから送られてきた配送先の情報を@orderに保存する作業
    @order = Order.new(order_params)
    #送料
    @order.shipping_cost = 800
    #送られてきた値が0.1.2によって分岐させて@orderに格納して保存
    if params[:order][:select_adress] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
      @order.save
      @address_info = address_info
    elsif params[:order][:select_adress] == "1"
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.save
      @address_info = address_info
    elsif params[:order][:select_adress] == "2"
      @order.save
      @address_info = address_info
    else
      flash[:notice] = '失敗'
      redirect_to
    end
    @cart_items = CartItem.all
    #合計金額の初期値を0にしておく
    @total = 0
  end

  def create
    #注文情報確認ページから送られてきた値をOrderに保存
    @order = Order.new(order_params)
    @order.save
    #↓OrderDetailにCartItemの情報を保存する作業
    #現在保存されているCartItemのレコードをeachメソッドで一個ずつ取り出して
    #@order_detailのカラムに各値を一つずつ格納して保存する
    @cart_items = CartItem.all
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item.id
      @order_detail.amount = cart_item.amount
      @order_detail.price = cart_item.item.price
      @order_detail.save
    end
    #保存が終わればCartItemのデータを全て削除
    current_customer.cart_items.destroy_all
    redirect_to complete_orders_path
  end

  def complete

  end

  def index
    @orders = Order.all
  end

  def show
    if Order.find_by(id: params[:id])
      @order = Order.find(params[:id])
    else
      flash[:alret] = "!error! 配送先を選んでください!"
      redirect_to new_order_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name,
    :shipping_cost, :total_payment, :customer_id)
  end

  def address_info
  '〒' + @order.postal_code + ' ' + @order.address + ' ' + @order.name
  end

end
