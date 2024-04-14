FactoryBot.define do
  factory :order do
    post_code { "123-4567" }
    delivery_place_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    street_address { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    telephone { "09012345678" }
    token { "tok_abcdefghijk00000000000000000" }
    association :user
    association :item
  end
end
