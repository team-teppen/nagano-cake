class Item < ApplicationRecord
  has_one_attached :image
  
  belongs_to :genre
  
  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true

  has_many :cart_items, dependent: :destroy
  
  def get_image
    if image.attached?
      image
    end
  end

  has_many :order_details, dependent: :destroy


  def with_tax_price
    (price * 1.1).floor
  end
end
