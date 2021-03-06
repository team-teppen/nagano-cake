class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:success] = "更新しました"
      redirect_to my_page_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    current_customer.update(is_deleted: true)
    sign_out current_customer
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :postal_code, :address, :email, :is_deleted)
  end
end
