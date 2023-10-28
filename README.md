# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## users テーブル
| Column               | Type   | Options                       |
| ------------------   | ------ | -----------                   |
| nickname             | string | null: false                   |
| email                | string | null: false, uniqueness: true |
| encrypted_password   | string | null: false                   |
| password_confirmation| string | null: false                   |
| last-name            | string | null: false                   |
| first-name           | string | null: false                   |
| last-name-kana       | string | null: false                   |
| first-name-kana      | string | null: false                   |
| birth-date           | integer| null: false                   |

### Association
- has_many :items
- has_many :orders
- has_many :shipping-addresses


## items テーブル
| Column                  | Type       | Options                         |
| -------                 | ---------- | ------------------------------  |
| item-name               | string     | null: false                     |
| item-info               | text       | null: false                     |
| item-category           | string     | null: false                     |
| item-sales-status       | string     | null: false                     |
| item-shipping-fee-status| string     | null: false                     |
| item-prefecture         | string     | null: false                     |
| item-scheduled-delivery | integer    | null: false                     |
| item-price              | integer    | null: false                     |
| seller-id               | references | null: false, foreign_key: true  |

### Association
- belongs_to :user
- has_one    :order


## orders テーブル
| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| seller-id        | references | null: false, foreign_key: true |
| buyer-id         | references | null: false, foreign_key: true |
| shipping-id      | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one    :shipping_address


## shipping_addresses テーブル
| Column             | Type       | Options                        |
| -----------------  | ---------- | ------------------------------ |
| postal-code        | integer    | null: false                    |
| prefecture         | string     |  null: false                   |
| city               | string     | null: false                    |
| addresses          | string     | null: false                    |
| building           | string     |                                |
| phone-number       | integer    | null: false                    |
| order-id           | references | null: false, foreign_key: true |

### Association
- belongs_to :order