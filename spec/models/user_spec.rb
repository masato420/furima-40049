require 'rails_helper'


RSpec.describe User, type: :model do
  describe '新規登録' do
    context '全ての項目が存在すれば登録できる' do
      it 'is valid with all attributes' do
        user = build(:user, nickname: "ユーザー名", email: "user@example.com", password: "Password123", last_name: "テスト", first_name: "太郎", last_name_kana: "テスト", first_name_kana: "タロウ", birthday: "2000-01-01")
        expect(user).to be_valid
      end
    end

    context '必須項目が欠けている場合は登録できない' do
      it 'is invalid without a nickname' do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors[:nickname]).to include("can't be blank")
      end

      it 'is invalid without an email' do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it 'is invalid without a password' do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end

      it 'is invalid without a last_name' do
        user = build(:user, last_name: nil)
        user.valid?
        expect(user.errors[:last_name]).to include("は全角（漢字・ひらがな・カタカナ）で入力してください")
      end

      it 'is invalid without a first_name' do
        user = build(:user, first_name: nil)
        user.valid?
        expect(user.errors[:first_name]).to include("は全角（漢字・ひらがな・カタカナ）で入力してください")
      end

      it 'is invalid without a last_name_kana' do
        user = build(:user, last_name_kana: nil)
        user.valid?
        expect(user.errors[:last_name_kana]).to include("はカタカナで入力してください。")
      end

      it 'is invalid without a first_name_kana' do
        user = build(:user, first_name_kana: nil)
        user.valid?
        expect(user.errors[:first_name_kana]).to include("はカタカナで入力してください。")
      end

      it 'is invalid without a birthday' do
        user = build(:user, birthday: nil)
        user.valid?
        expect(user.errors[:birthday]).to include("can't be blank")
      end
   end
  end
  describe "カタカナ validation" do
    it "is valid with カタカナ for last_name_kana" do
      user = build(:user, last_name: "テスト", first_name: "太郎", last_name_kana: "カタカナ", first_name_kana: "カタカナ")
      expect(user).to be_valid
    end

    it "is invalid without カタカナ for last_name_kana" do
      user = build(:user, last_name_kana: "かたかな")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("はカタカナで入力してください。")
    end

    it "is valid with カタカナ for first_name_kana" do
      user = build(:user, last_name: "山田", first_name: "太郎", last_name_kana: "カタカナ", first_name_kana: "カタカナ")
      expect(user).to be_valid
    end

    it "is invalid without カタカナ for first_name_kana" do
      user = build(:user, first_name_kana: "かたかな")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("はカタカナで入力してください。")
    end
  end
end