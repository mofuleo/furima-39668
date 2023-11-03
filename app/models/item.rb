class Item < ApplicationRecord

  validates :item_name,            presence: true
  validates :item_info,            presence: true
  validates :category_id,          presence: true
  validates :condition_name,       presence: true
  validates :shipping_fee_id,      presence: true
  validates :prefecture_id,        presence: true
  validates :scheduled_delivery_id,presence: true
  validates :item_price,           presence: true
  validates :image,                presence: true

  belongs_to :user
  has_one_attached :image
end
