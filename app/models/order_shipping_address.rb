class OrderShippingAddress
include ActiveModel::Model

attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id

with_options presence:true do
  
  validates :postal_code,format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  
  validates :city
  validates :addresses
  validates :phone_number
  validates :order_id
  validates :user_id
  validates :item_id
  validates :prefecture_id: numericality: {other_than: 0, message: "can't be blank"}
end

belongs_to:order

def save
  order = Order.create(user_id:user_id,item_id:item_id)
  ShippingAddres.create(postal_code:postal_code, prefecture_id:prefecture_id, city:city,addresses:addresses, building:building, phone_number:phone_number, order_id:order.id)
end