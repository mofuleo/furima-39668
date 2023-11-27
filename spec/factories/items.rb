FactoryBot.define do
  factory :item do
    association :user

    item_name { Faker::Lorem.word }
    item_info { Faker::Lorem.sentence }
    category_id { Faker::Number.within(range: 2..11) }
    condition_id { Faker::Number.within(range: 2..7) }
    shipping_fee_id { Faker::Number.within(range: 2..3) }
    prefecture_id { Faker::Number.within(range: 2..48) }
    scheduled_delivery_id { Faker::Number.within(range: 2..4) }
    item_price { Faker::Number.within(range: 300..9_999_999) }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/sample.jpg'), filename: 'sample.jpg')
    end
  end
end
