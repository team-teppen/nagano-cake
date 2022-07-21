class Public::AddressesController < ApplicationController
  
    before_action :authenticate_customer!

    
    def index
        @address = Address.new
        @addresses = Address.all
    end
    
    def edit
      @address = Address.find(params[:id])
      
    end
    
    def create
      @address = Address.new(address_params)
      if @address.save
        flash[:success] = "登録しました"
        redirect_to addresses_path(@address)
      else
        @addresses = Address.all
        render :index
      end  
    end
    
    def update
      @address = Address.find(params[:id])
      @address.update(address_params)
      flash[:success] = "更新しました"
      redirect_to addresses_path(@address)
    end
    
    def destroy
      @address = Address.find(params[:id])
      @address.destroy
      flash[:success] = "削除しました"
      redirect_to addresses_path
    end
    
    
    private
    
    def address_params
        params.require(:address).permit(:customer_id, :name, :postal_code, :address)
    end
  
end
