class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
   enum making_status: {
    impossible_manufacture: 0,
    waiting_manufacture: 1,
    manufacturing: 2,
    finish: 3
  }
  
  def subtotal
    #item.rbで定義したwith_tax_priceメソッドを使って小計を計算するメソッド
    item.with_tax_price * amount
  end
    
end
