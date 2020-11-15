class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :street_number, :building_number, :phone_number, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture, numericality: { other_than: 1, message: 'should be chosen' }
    validates :city
    validates :street_number
    validates :phone_number, format: { with: /\A\d{11}\z/, message: 'should be 11 numbers' }
    validates :token
  end

  def save(current_user, item)
    order = Order.create(user_id: current_user.id, item_id: item.id)
    ShippingAddress.create(postal_code: postal_code, prefecture: prefecture, city: city, street_number: street_number, building_number: building_number, phone_number: phone_number, order_id: order.id)
  end
end
