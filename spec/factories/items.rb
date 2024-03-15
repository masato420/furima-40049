FactoryBot.define do
  factory :item do
    item_name { Faker::Commerce.product_name }
    explanation { Faker::Lorem.sentence(word_count: 3) }
    category_id { Faker::Number.between(from: 2, to: 11) }
    condition_id { Faker::Number.between(from: 2, to: 7) }
    delivery_charge_id { Faker::Number.between(from: 2, to: 3) }
    delivery_place_id { Faker::Number.between(from: 2, to: 48) }
    delivery_day_id { Faker::Number.between(from: 2, to: 4) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec/fixtures/sample.png')), filename: 'sample.png', content_type: 'image/png')
    end
  end
end