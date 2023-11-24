class OrderShippingAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }

    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A0\d{9}\d?\z/ }
    validates :user_id
    validates :item_id
    validates :prefecture_id, numericality: { other_than: 1 }
  end

  def save
    order = Order.create(user_id:, item_id:)

    ShippingAddress.create(postal_code:, prefecture_id:, city:, addresses:, building:,
                           phone_number:, order_id: order.id)
  end
end
