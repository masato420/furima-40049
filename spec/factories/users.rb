FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    last_name_kana { "カタカナ" }
    first_name_kana { "カタカナ" }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    birthday { Faker::Date.between(from: '1990-01-01', to: '2000-12-31') }
  end
end