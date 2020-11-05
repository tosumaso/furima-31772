# テーブル設計

## usersテーブル

|Column              |Type        |Options      |
|--------------------|------------|-------------|
|email               |string      |null: false  |
|password            |string      |null: false  |
|nickname            |string      |null: false  |
|nickname            |string      |null: false  |
|family_name         |string      |null: false  |
|first_name          |string      |null: false  |
|katakana_family_name|string      |null: false  |
|katakana_family_name|string      |null: false  |
|birthday            |date        |null: false  |

### Association

user has_many :items
user has_many :orders

## itemsテーブル

|Column             |Type      |Options                       |
|-------------------|----------|------------------------------|
|name               |string    |null: false                   |
|price              |integer   |null: false                   |
|exhibitor          |string    |null: false                   |
|category           |string    |null: false                   |
|status             |text      |null: false                   |
|delivery_charge    |integer   |null: false                   |  
|delivery_source    |integer   |null: false                   | 
|delivery_estimated |integer   |null: false                   |
|user               |references|null: false, foreign_key: true|

### Association

item belongs_to :user
item has_one :order

## ordersテーブル

|Column        |Type      |Options                       |
|--------------|----------|------------------------------|
|user          |references|null: false, foreign_key: true|
|item          |references|null: false, foreign_key: true|

### Association

order belongs_to :user
order belongs_to :item
order has_one :shipping_address

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

shipping_address belongs_to :order
