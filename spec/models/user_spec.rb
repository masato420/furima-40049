require 'rails_helper'

RSpec.describe User, type: :model do
  context '新規登録ができる時' do
    it '' do
    end
  end

  context '新規登録ができない時' do
    it '' do
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