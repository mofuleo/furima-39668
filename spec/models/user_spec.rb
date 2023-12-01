require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation,fitstname,lastname,firstname_kana,lastname_kana,
        birthdayが正しく存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'emailが既に使われていると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailに@が入っていないと登録できない' do
        @user.email = 'test.test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが数字だけでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordが英字だけでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordに全角（漢字）が入っていると登録できない' do
        @user.password = '12345a野比'
        @user.password_confirmation = '12345a野比'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordに全角（ひらがな）が入っていると登録できない' do
        @user.password = '12345aのびた'
        @user.password_confirmation = '12345aのびた'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordに全角（カタカナ）が入っていると登録できない' do
        @user.password = '12345aノビタ'
        @user.password_confirmation = '12345aノビタ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'passwordとPassword_conformatilnが違うと登録できない' do
        @user.password = '123456a'
        @user.password_confirmation = '123456b'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（全角）姓は不正な値です', 'お名前（全角）姓を入力してください')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（全角）名は不正な値です')
      end
      it 'last_nameが全角（漢字ひらがなカタカナ）以外（英字）では登録できない' do
        @user.last_name = 'Smith'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（全角）姓は不正な値です')
      end
      it 'last_nameが全角（漢字ひらがなカタカナ）以外（数字）では登録できない' do
        @user.last_name = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（全角）姓は不正な値です')
      end
      it 'first_nameが全角（漢字ひらがなカタカナ）以外（英字）では登録できない' do
        @user.first_name = 'Mary'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（全角）名は不正な値です')
      end
      it 'first_nameが全角（漢字ひらがなカタカナ）以外（数字）では登録できない' do
        @user.first_name = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（全角）名は不正な値です')
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（全角）姓は不正な値です", "お名前カナ（全角）姓を入力してください")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（全角）名を入力してください")
      end
      it 'last_name_kanaが全角（カタカナ）以外（漢字）では登録できない' do
        @user.last_name_kana = '田中'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（全角）姓は不正な値です')
      end
      it 'last_name_kanaが全角（カタカナ）以外(ひらがな）では登録できない' do
        @user.last_name_kana = 'たなか'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（全角）姓は不正な値です')
      end
      it 'last_name_kanaが全角（カタカナ）以外（英字）では登録できない' do
        @user.last_name_kana = 'tanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（全角）姓は不正な値です')
      end
      it 'last_name_kanaが全角（カタカナ）以外（数字）では登録できない' do
        @user.last_name_kana = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（全角）姓は不正な値です')
      end
      it 'first_name_kanaが全角（カタカナ）以外（漢字）では登録できない' do
        @user.first_name_kana = '芽亜里'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（全角）名は不正な値です')
      end
      it 'first_name_kanaが全角（カタカナ）以外(ひらがな) では登録できない' do
        @user.first_name_kana = 'めありー'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（全角）名は不正な値です')
      end
      it 'first_name_kanaが全角（カタカナ）以外（英字）では登録できない' do
        @user.first_name_kana = 'Mary'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（全角）名は不正な値です')
      end
      it 'first_name_kanaが全角（カタカナ）以外(数字) では登録できない' do
        @user.first_name_kana = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（全角）名は不正な値です')
      end
      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
