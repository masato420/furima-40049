require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  describe "カタカナ validation" do
    it "is valid with valid カタカナ for last_name_kana" do
      user = build(:user, last_name_kana: "カタカナ")
      expect(user).to be_valid
    end

    it "is invalid without カタカナ for last_name_kana" do
      user = build(:user, last_name_kana: "かたかな")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("はカタカナで入力してください")
    end

    it "is valid with valid カタカナ for last_name_kana" do
      user = build(:user, first_name_kana: "カタカナ")
      expect(user).to be_valid
    end

    it "is invalid without カタカナ for last_name_kana" do
      user = build(:user, first_name_kana: "かたかな")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("はカタカナで入力してください")
    end
  end
end