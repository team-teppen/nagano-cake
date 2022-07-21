class Address < ApplicationRecord

  belongs_to :customer

  def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
  end

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

end
