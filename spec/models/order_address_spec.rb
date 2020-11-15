require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  describe '商品購入機能' do
    context '購入できる時' do
      it 'postal_code,prefecture,city,street_number,building_number,phone_numberが入力された場合' do
        expect(@order_address).to be_valid
      end
      it 'building_number以外が入力された場合' do
        @order_address.building_number = ''
        expect(@order_address).to be_valid
      end
      it 'postal_codeにハイフン(-)がついてる場合' do
        @order_address.postal_code = '123-4567'
        expect(@order_address).to be_valid
      end
      it '電話番号が11桁の数字の場合' do
        @order_address.phone_number = '00000000000'
        expect(@order_address).to be_valid
      end
    end

    context '購入できない時' do
      it 'postal_codeがない場合' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid. Include hyphen(-)')
      end
      it 'prefectureがない場合' do
        @order_address.prefecture = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank", 'Prefecture should be chosen')
      end
      it 'cityがない場合' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'street_numberがない場合' do
        @order_address.street_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street number can't be blank")
      end
      it 'phone_numberがない場合' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank", 'Phone number should be 11 numbers')
      end
      it 'postal_codeにハイフン(-)がついてない場合' do
        @order_address.postal_code = '0000000'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'postal_codeが７桁以外の場合' do
        @order_address.postal_code = '000-000'
        @order_address.invalid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'postal_codeが数字以外の場合' do
        @order_address.postal_code = 'あいうえお-かき'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'phone_numberが11桁以上の場合' do
        @order_address.phone_number = '000000000000'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number should be 11 numbers')
      end
      it 'phone_numberが数字以外の場合' do
        @order_address.phone_number = 'あいうえおかきくけこさ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number should be 11 numbers')
      end
      it 'prefectureのプルダウンが"---"の場合' do
        @order_address.prefecture = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture should be chosen')
      end

      it 'tokenが空の場合' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
