require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    @order_shipping_address = FactoryBot.build(:order_shipping_address)
    @order_shipping_address.item_id = 1
    @order_shipping_address.user_id = 2
    @order_shipping_address.token = 'aaaaaaaa'
  end

  describe '配送先登録' do
    context '登録できるとき' do
      it '郵便番号、都道府県、市町村、住所、電話番号が正しく入力されていれば配送先が登録できる' do
        expect(@order_shipping_address).to be_valid
      end
      it '建物名がなくても登録できる' do
        @order_shipping_address.building = ''
        expect(@order_shipping_address).to be_valid
      end
    end

    context '登録ができないとき' do
      it '郵便番号が空だと登録できない' do
        @order_shipping_address.postal_code = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid')
      end
      it 'postal_codeが半角ハイフンを含んでないと保存できないこと' do
        @order_shipping_address.postal_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Postal code is invalid')
      end
      it 'postal_codeが全角ハイフンを含んでいると保存できないこと' do
        @order_shipping_address.postal_code = '123ー4567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Postal code is invalid')
      end
      it 'postal_codeが（3桁-4桁の）正しい形式でないと保存できないこと' do
        @order_shipping_address.postal_code = '12345-67'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Postal code is invalid')
      end
      it '都道府県が空だと登録できない' do
        @order_shipping_address.prefecture_id = 1
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '市町村が空だと登録できない' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it '住所が空だと登録できない' do
        @order_shipping_address.addresses = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Addresses can't be blank")
      end
      it '電話番号が空だと登録できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンが含まれていると登録できない' do
        @order_shipping_address.phone_number = '090-1234-5678'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が0から始まっていないと登録できない' do
        @order_shipping_address.phone_number = '90123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が10桁より少ないと登録できない' do
        @order_shipping_address.phone_number = '090123456'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上だと登録できない' do
        @order_shipping_address.phone_number = '090123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空だと登録できない' do
        @order_shipping_address.token = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_shipping_address.item_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_shipping_address.user_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
