class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :amount, presence: true


  def subtotal
    #item.rbで定義したwith_tax_priceメソッドを使って小計を計算するメソッド
    item.with_tax_price * amount
  end
end
