class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :items

    with_options :presence => true do
    validates :nickname

  with_options :format => { :with => /\A[ぁ-んァ-ン一-龥]+\z/ } do
    validates :family_name
    validates :first_name
  end

  with_options :format => { :with => /\A[ァ-ヶー－]+\z/ } do
    validates :katakana_family_name
    validates :katakana_first_name
  end
  validates :birthday
  end

  validates :password, :format => { :with => /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/ }
end



