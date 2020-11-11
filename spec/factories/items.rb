FactoryBot.define do
  factory :item do
    name                  { Faker::Food.fruits }
    item_detail           { Faker::Food.description }
    category_id           { Faker::Number.between(from: 2, to: 11) }
    status_id             { Faker::Number.between(from: 2, to: 7) }
    delivery_charge_id    { Faker::Number.between(from: 2, to: 3) }
    delivery_source_id    { Faker::Number.between(from: 2, to: 48) }
    delivery_estimated_id { Faker::Number.between(from: 2, to: 4) }
    price                 { Faker::Number.between(from: 300, to: 9_999_999) }

    association :user

    after(:build) do |object|
      object.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
