
require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  describe '新規登録' do
    context '全ての項目が存在すれば登録できる' do
      it 'is valid with all attributes' do
        expect(@user).to be_valid
      end
    end

    context '必須項目が欠けている場合は登録できない' do
      it 'is invalid without a nickname' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors[:nickname]).to include("can't be blank")
      end

      it 'is invalid without an email' do
        @user.email = nil
        expect(@user).to_not be_valid
        expect(@user.errors[:email]).to include("can't be blank")
      end
  
      it 'is invalid with a duplicate email address' do
        existing_user = create(:user, email: 'test@example.com', last_name: '山田', first_name: '太郎')
        @user.email = existing_user.email
        expect(@user).to_not be_valid
        expect(@user.errors[:email]).to include("has already been taken")
      end
  
      it 'is invalid without "@" in the email' do
        @user.email = 'userexample.com'
        @user.valid?
        expect(@user.errors[:email]).to include("is invalid")
      end
  
      # パスワード関連
      it 'is invalid without a password' do
        @user.password = nil
        expect(@user).to_not be_valid
        expect(@user.errors[:password]).to include("can't be blank")
      end
  
      it 'is invalid with a password shorter than 6 characters' do
        @user.password = 'pass'
        expect(@user).to_not be_valid
        expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end
  
      it 'is invalid with a password without confirmation' do
        @user.password_confirmation = 'different'
        expect(@user).to_not be_valid
        expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      # パスワードが半角数字のみの場合は登録できない
      it 'is invalid with a password that is all digits' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors[:password]).to include("は半角英字と数字の両方を含めて設定してください")
      end

      # パスワードが半角英字のみの場合は登録できない
      it 'is invalid with a password that is all letters' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors[:password]).to include("は半角英字と数字の両方を含めて設定してください")
      end

      # パスワードが全角の場合は登録できない
      it 'is invalid with a password that contains full-width characters' do
        @user.password = 'ａｂｃ１２３'
        @user.password_confirmation = 'ａｂｃ１２３'
        @user.valid?
        expect(@user.errors[:password]).to include("は半角英字と数字の両方を含めて設定してください")
      end
  
      # 名前関連
      it 'is invalid without a last name' do
        @user.last_name = nil
        expect(@user).to_not be_valid
        expect(@user.errors[:last_name]).to include("can't be blank")
      end
  
      it 'is invalid without a first name' do
        @user.first_name = nil
        expect(@user).to_not be_valid
        expect(@user.errors[:first_name]).to include("can't be blank")
      end
  
      it 'is invalid with a last name not in full-width characters' do
        @user.last_name = 'Yamada'
        expect(@user).to_not be_valid
        expect(@user.errors[:last_name]).to include("is invalid")
      end
  
      it 'is invalid with a first name not in full-width characters' do
        @user.first_name = 'Taro'
        expect(@user).to_not be_valid
        expect(@user.errors[:first_name]).to include("is invalid")
      end
  
      # カナ関連
      it 'is invalid without a last name kana' do
        @user.last_name_kana = nil
        expect(@user).to_not be_valid
        expect(@user.errors[:last_name_kana]).to include("はカタカナで入力してください。")
      end
  
      it 'is invalid without a first name kana' do
        @user.first_name_kana = nil
        expect(@user).to_not be_valid
        expect(@user.errors[:first_name_kana]).to include("はカタカナで入力してください。")
      end
  
      it 'is invalid with a last name kana not in full-width katakana' do
        @user.last_name_kana = 'やまだ'
        expect(@user).to_not be_valid
        expect(@user.errors[:last_name_kana]).to include("はカタカナで入力してください。")
      end
  
      it 'is invalid with a first name kana not in full-width katakana' do
        @user.first_name_kana = 'たろう'
        expect(@user).to_not be_valid
        expect(@user.errors[:first_name_kana]).to include("はカタカナで入力してください。")
      end
  
      # 誕生日関連
      it 'is invalid without a birthday' do
        @user.birthday = nil
        expect(@user).to_not be_valid
        expect(@user.errors[:birthday]).to include("can't be blank")
      end
    end
  end
end