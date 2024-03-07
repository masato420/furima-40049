FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username(specifier: 5..8) }
    last_name { Gimei.last.kanji }
    first_name { Gimei.first.kanji }
    last_name_kana { Gimei.last.katakana }
    first_name_kana { Gimei.first.katakana }
    email { Faker::Internet.email }
    password { "1a#{Faker::Internet.password(min_length: 8, max_length: 20)}" }
    password_confirmation { password }
    birthday { Faker::Date.between(from: '1990-01-01', to: '2000-12-31') }
  end
end
