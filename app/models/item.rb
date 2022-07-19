class Item < ApplicationRecord
  has_one_attached :image
  
  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true
  
  has_many :cart_items, dependent: :destroy


  def with_tax_price
    (price * 1.1).floor
  end
end
