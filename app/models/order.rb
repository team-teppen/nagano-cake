class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum status: {入金待ち: 0,入金確認: 1,製作中: 2,発送準備中: 3,発送済み: 4}

  def all_total_payment
    total_payment + shipping_cost
  end

end
