class Item < ApplicationRecord

  validates :item_name,            presence: true
  validates :item_info,            presence: true
  validates :category_id,          presence: true
  validates :condition_id,         presence: true
  validates :shipping_fee_id,      presence: true
  validates :prefecture_id,        presence: true
  validates :scheduled_delivery_id,presence: true
  validates :item_price,           presence: true, numericality:{ only_integer: true,greater_than_or_equal_to: 300,less_than_or_equal_to: 9999999, 
    message: "Out of setting range"}
  validates :image,                presence: true

  
extend ActiveHash::Associations::ActiveRecordExtensions
belongs_to_active_hash :category
belongs_to_active_hash :condition
belongs_to_active_hash :shipping_fee
belongs_to_active_hash :prefecture
belongs_to_active_hash :scheduled_delivery

  validates :category_id,           numericality:  { other_than: 1,message:"can't be blank" } 
  validates :condition_id,          numericality:  { other_than: 1,message:"can't be blank" } 
  validates :shipping_fee_id,       numericality:  { other_than: 1,message:"can't be blank" } 
  validates :prefecture_id,         numericality:  { other_than: 1,message:"can't be blank" } 
  validates :scheduled_delivery_id, numericality:  { other_than: 1,message:"can't be blank" } 

  belongs_to :user
  has_one_attached :image

end