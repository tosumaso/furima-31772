FactoryBot.define do
  factory :order_address do
    postal_code     { '443-5687' }
    prefecture      { 5 }
    city            { '横浜市' }
    street_number   { '123' }
    building_number { '456' }
    phone_number    { '00000000000' }
    token           { 'tok_abcdefghijk00000000000000000' }
  end
end
