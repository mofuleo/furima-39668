require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品登録' do
    context '商品登録ができるとき' do
      it '写真,商品名、商品説明、カテゴリー、商品の状態、送料負担、祖発送元、送付日、商品価格が正しく入力されていれば商品が登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品登録ができないとき' do
      it '写真が空だと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it '商品名が空だと登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品説明が空だと登録できない' do
        @item.item_info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'カテゴリーが空だと登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end
      it 'コンディションが空だと登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end
      it '送料負担者が空だと登録できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it '発送元が空だと登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送元の都道府県を入力してください")
      end
      it '発送日が空だと登録できない' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送の時期を入力してください")
      end
      it '商品価格が空だと登録できない' do
        @item.item_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品価格を入力してください")
      end
      it '商品価格が300円未満だと登録できない' do
        @item.item_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("商品価格300円以上1000万円未満で設定してください")
      end
      it '商品価格が10000000円以上だと登録できない' do
        @item.item_price = 100_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('商品価格300円以上1000万円未満で設定してください')
      end
      it '商品価格が半角数字以外（全角数字）だと登録できない' do
        @item.item_price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('商品価格300円以上1000万円未満で設定してください')
      end
      it '商品にユーザー情報がないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
