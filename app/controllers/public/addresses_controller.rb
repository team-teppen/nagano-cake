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
      @address.save
      redirect_to addresses_path(@address)
    end
    
    def update
    end
    
    def destroy
      @address = Address.find(params[:id])
      @address.destroy
      redirect_to addresses_path
    end
    
    
    private
    
    def address_params
        params.require(:address).permit(:customer_id, :name, :postal_code, :address)
    end
  
end
