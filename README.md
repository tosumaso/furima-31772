# テーブル設計

## usersテーブル

|Column              |Type        |Options      |
|--------------------|------------|-------------|
|email               |string      |null: false  |
|encrypted_password  |string      |null: false  |
|nickname            |string      |null: false  |
|family_name         |string      |null: false  |
|first_name          |string      |null: false  |
|katakana_family_name|string      |null: false  |
|katakana_first_name |string      |null: false  |
|birthday            |date        |null: false  |

### Association

has_many :items
has_many :orders

## itemsテーブル

|Column                |Type      |Options                       |
|----------------------|----------|------------------------------|
|name                  |string    |null: false                   |
|price                 |integer   |null: false                   |
|item_detail           |text      |null: false                   |
|category_id           |integer   |null: false                   |
|status_id             |integer   |null: false                   |
|delivery_charge_id    |integer   |null: false                   |  
|delivery_source_id    |integer   |null: false                   | 
|delivery_estimated_id |integer   |null: false                   |
|user                  |references|null: false, foreign_key: true|

### Association

belongs_to :user
has_one :order

## ordersテーブル

|Column        |Type      |Options                       |
|--------------|----------|------------------------------|
|user          |references|null: false, foreign_key: true|
|item          |references|null: false, foreign_key: true|

### Association

belongs_to :user
belongs_to :item
has_one :shipping_address

# shipping_addressesテーブル

|Column             |Type      |Options                       |
|-------------------|----------|------------------------------|
|postal_code        |string    |null: false                   |
|prefecture_id      |integer   |null: false                   |
|city               |string    |null: false                   |
|street_number      |string    |null: false                   |
|building_number    |string    |                              |
|phone_number       |string    |null: false                   |
|order              |references|null: false, foreign_key: true|

### Association

belongs_to :order
