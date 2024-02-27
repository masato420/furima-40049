# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many  :purchases

## items テーブル

| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| item_name          | string     | null: false                     |
| explanation        | text       | null: false                     |
| category_id        | integer    | null: false                     |
| condition_id       | integer    | null: false                     |
| delivery_charge_id | integer    | null: false                     |
| delivery_place_id  | integer    | null: false                     |
| delivery_day_id    | integer    | null: false                     |
| price              | integer    | null: false                     |
| user               | references | null: false, foreign_key: true  |

### Association

- belongs_to :user
- has_one    :purchase

## shippings テーブル

| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| post_code          | string     | null: false                     |
| delivery_place_id  | integer    | null: false                     |
| city               | string     | null: false                     |
| street_address     | string     | null: false                     |
| building_name      | string     |                                 |
| telephone          | string     | null: false                     |
| purchase           | references | null: false, foreign_key: true  |

### Association

- belongs_to :purchase

## purchases テーブル

| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| user               | references | null: false, foreign_key: true  |
| item               | references | null: false, foreign_key: true  |

### Association

- belongs_to :user
- belongs_to :item
- has_one  :shipping
