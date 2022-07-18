class Public::CustomersController < ApplicationController
  def show
  end
  
  def edit
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = "更新しました"
      redirect_to my_page_path(@customer.id)
    else
      render :edit
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
  end
  
  private
  
  def customers_params
    params.require(:customers).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :postal_code, :address, :email)
  end
end
