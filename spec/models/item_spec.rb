require 'rails_helper'

describe Item do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品がうまく行く時' do
      it 'image, price, name, item_detail, category_id, status_id, delivery_charge_id, delivery_source_id, delivery_estimated_idが登録された場合' do
        expect(@item).to be_valid
      end
      it 'nameが40文字以内の場合' do
        @item.name = 'テスト'
        expect(@item).to be_valid
      end
      it 'item_detailが1000文字以内の場合' do
        @item.item_detail = 'テスト用テキスト'
        expect(@item).to be_valid
      end
      it 'priceが300円以上の場合' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it 'priceが9999999円以内の場合' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end
    context '商品出品がうまく行かない時' do
      it 'imageが無い場合' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Image cannot be blank')
      end
      it 'nameが無い場合' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'nameが40字を超える場合' do
        @item.name = ('a' * 41)
        @item.valid?
        expect(@item.errors.full_messages).to include('Name is too long (maximum is 40 characters)')
      end
      it 'item_detailが無い場合' do
        @item.item_detail = nil
        @item.valid?

        expect(@item.errors.full_messages).to include("Item detail can't be blank")
      end
      it 'item_detailが1000字を超える場合' do
        @item.item_detail = ('a' * 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include('Item detail is too long (maximum is 1000 characters)')
      end
      it 'category_idが無い場合' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'status_idが無い場合' do
        @item.status_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it 'delivery_charge_idが無い場合' do
        @item.delivery_charge_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end
      it 'delivery_source_idが無い場合' do
        @item.delivery_source_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery source can't be blank")
      end
      it 'delivery_estimated_idが無い場合' do
        @item.delivery_estimated_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery estimated can't be blank")
      end
      it 'priceが無い場合' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが300円未満の場合' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it 'priceが9999999円より高い場合' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it 'priceが全角の場合' do
        @item.price = '１０００００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceが文字列の場合' do
        @item.price = '文字列'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'userと紐づいていない場合' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
      it 'category_idが --- の場合' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be selected')
      end
      it 'status_idが --- の場合' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status must be selected')
      end
      it 'delivery_charge_idが --- の場合' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery charge must be selected')
      end
      it 'delivery_source_idが --- の場合' do
        @item.delivery_source_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery source must be selected')
      end
      it 'delivery_estimated_idが --- の場合' do
        @item.delivery_estimated_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery estimated must be selected')
      end
    end
  end
end
