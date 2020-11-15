class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :delivery_source
  belongs_to :delivery_estimated
  has_one_attached :image
  belongs_to :user

  validate :image_validation

  def image_validation
    errors.add(:base, 'Image cannot be blank') unless image.attached?
  end

  with_options presence: true do
    validates :name, length: { in: 1..40 }
    validates :item_detail, length: { in: 1..1000 }

    with_options numericality: { other_than: 1, message: 'must be selected' } do
      validates :category_id
      validates :status_id
      validates :delivery_charge_id
      validates :delivery_source_id
      validates :delivery_estimated_id
    end
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }, format: { with: /\A-?[0-9]+(\.[0-9]+)?\z/ }
  end
end
