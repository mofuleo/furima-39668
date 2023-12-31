require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  describe '配送先登録' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)

      @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: user.id, item_id: item.id)

      @order_shipping_address.token = 'aaaaaaaa'
    end

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
        expect(@order_shipping_address.errors.full_messages).to include("郵便番号を入力してください", '郵便番号は不正な値です')
      end
      it 'postal_codeが半角ハイフンを含んでないと保存できないこと' do
        @order_shipping_address.postal_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it 'postal_codeが全角ハイフンを含んでいると保存できないこと' do
        @order_shipping_address.postal_code = '123ー4567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it 'postal_codeが（3桁-4桁の）正しい形式でないと保存できないこと' do
        @order_shipping_address.postal_code = '12345-67'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it '都道府県が空だと登録できない' do
        @order_shipping_address.prefecture_id = 1
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('都道府県を選択してください')
      end
      it '市町村が空だと登録できない' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it '住所が空だと登録できない' do
        @order_shipping_address.addresses = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号が空だと登録できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号にハイフンが含まれていると登録できない' do
        @order_shipping_address.phone_number = '090-1234-5678'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('電話番号は不正な値です')
      end

      it '電話番号が10桁より少ないと登録できない' do
        @order_shipping_address.phone_number = '090123456'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it '電話番号が12桁以上だと登録できない' do
        @order_shipping_address.phone_number = '090123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'tokenが空だと登録できない' do
        @order_shipping_address.token = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("カード情報を入力してください")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_shipping_address.item_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Itemを入力してください")
      end
      it 'userが紐付いていないと保存できないこと' do
        @order_shipping_address.user_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
