FactoryBot.define do
  factory :order_shipping_address do
    postal_code { '123-4567' }
    prefecture_id { Faker::Number.within(range: 2..48) }
    city { Faker::Address.city }
    addresses { Faker::Address.street_address }
    building { Faker::Lorem.sentence }
    phone_number { '09012345678' }
  end
end
