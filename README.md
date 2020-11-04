# テーブル設計

## usersテーブル

|Column              |Type        |Options      |
|--------------------|------------|-------------|
|email               |string      |null: false  |
|password            |string      |null: false  |
|nickname            |string      |null: false  |
|family_name         |string      |null: false  |
|first_name          |string      |null: false  |
|katakana_family_name|string      |null: false  |
|katakana_family_name|string      |null: false  |

## itemsテーブル

|Column             |Type      |Options                       |
|-------------------|----------|------------------------------|
|item_name          |string    |null: false                   |
|price              |integer   |null: false                   |
|exhibitor          |string    |null: false                   |
|category           |string    |null: false                   |
|item_status        |text      |null: false                   |
|delivery-charge    |string    |null: false                   |  
|delivery_source    |string    |null: false                   | 
|delivery_estimated |string    |null: false                   |
|user               |references|null: false, foreign_key: true|

## ordersテーブル

|Column        |Type      |Options                       |
|--------------|----------|------------------------------|
|who_bought    |string    |null: false                   |
|when_bought   |date      |null: false                   |
|what_bought   |string    |null: false                   |
|user          |references|null: false, foreign_key: true|

# shipping_addressesテーブル

|Column             |Type      |Options                       |
|-------------------|----------|------------------------------|
|postal_code        |integer   |null: false                   |
|prefecture         |string    |null: false                   |
|city               |string    |null: false                   |
|street_number      |string    |null: false                   |
|building_number    |text      |                              |
|phone_number       |integer   |null: false                   |
|user               |references|null: false, foreign_key: true|
|order              |references|null: false, foreign_key: true|

### Association

user has_many :items
user has_many :shipping_addresses
user has_many :orders

item belongs_to :user

order belongs_to :user
order has_one :shipping_address

shipping_address belongs_to :order
