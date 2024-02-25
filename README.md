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
- has_many :comments


## items テーブル

| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| item_name          | string     | null: false                     |
| explanation        | text       | null: false                     |
| category_id        | references | null: false,foreign_key:true    |
| condition_id       | references | null: false,foreign_key:true    |
| delivery_charge_id | references | null: false,foreign_key:true    |
| delivery_place_id  | integer    | null: false                     |
| delivery_day_id    | references | null: false,foreign_key:true    |
| price              | decimal    | null: false                     |
| user_id            | references | null: false, foreign_key: true  |

### Association

- belongs_to :user
- belongs_to :category
- belongs_to :condition
- belongs_to :delivery_charge
- belongs_to :delivery_day
- has_many   :comments
- has_one    :purchase

## shippings テーブル

| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| post_code          | string     | null: false                     |
| prefectures        | integer    | null: false                     |
| city               | string     | null: false                     |
| street_address     | string     | null: false                     |
| building_name      | string     | null: false                     |
| telephone          | string     | null: false                     |
| purchase_id        | references | null: false, foreign_key: true  |

### Association

- belongs_to :purchase

## purchases テーブル

| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| user_id            | references | null: false, foreign_key: true  |
| item_id            | references | null: false, foreign_key: true  |

### Association

- belongs_to :item
- has_one  :shipping

## comments テーブル

| Column             | Type       | Options                         |
| ------------------ | ---------- | --------------------------------|
| user_id            | references | null: false, foreign_key: true  |
| item_id            | references | null: false, foreign_key: true  |
| text               | text       | null: false                     |

### Association

- belongs_to :user
- belongs_to :item

## categories テーブル

| Column    | Type    | Options                  |
|-----------|---------|--------------------------|
| id        | integer | null: false, primary key |
| name      | string  | null: false              |

id | name
---|----------------
1  | レディース
2  | メンズ
3  | ベビー・キッズ
4  | インテリア・住まい・小物
5  | 本・音楽・ゲーム
6  | おもちゃ・ホビー・グッズ
7  | 家電・スマホ・カメラ
8  | スポーツ・レジャー
9  | ハンドメイド
10 | その他

### Association

has_many :items

## conditions テーブル

| Column    | Type    | Options                  |
|-----------|---------|--------------------------|
| id        | integer | null: false, primary key |
| name      | string  | null: false              |

id | name
---|----------------
1  | 新品・未使用
2  | 未使用に近い
3  | 目立った傷や汚れなし
4  | やや傷や汚れあり
5  | 傷や汚れあり
6  | 全体的に状態が悪い

### Association

has_many :items

## delivery_charges テーブル

| Column    | Type    | Options                  |
|-----------|---------|--------------------------|
| id        | integer | null: false, primary key |
| name      | string  | null: false              |

id | name
---|----------------
1  | 着払い(購入者負担)
2  | 送料込み(出品者負担)

### Association

has_many :items

## delivery_day テーブル

| Column    | Type    | Options                  |
|-----------|---------|--------------------------|
| id        | integer | null: false, primary key |
| name      | string  | null: false              |

id | name
---|----------------
1  | 1~2日で発送
2  | 2~3日で発送
3  | 3~4日で発送

### Association

has_many :items
