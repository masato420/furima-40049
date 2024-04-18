require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    buyer = FactoryBot.create(:user)
    seller = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user_id: seller.id)
    @order = FactoryBot.build(:order, user_id: buyer.id, item_id: item.id)
  end

  context '正常系テスト' do
    it '電話番号が10桁の場合は保存が可能' do
      @order.telephone = '0123456789'
      @order.token = 'tok_abcdefghijk00000000000000000'
      expect(@order).to be_valid
    end

    it '電話番号が11桁の場合は保存が可能' do
      @order.telephone = '01234567890'
      @order.token = 'tok_abcdefghijk00000000000000000'
      expect(@order).to be_valid
    end

    it '@orderが有効であること' do
      expect(@order).to be_valid
    end

    it '建物名が空でも登録できること' do
      @order.building_name = ''
      expect(@order).to be_valid
    end
  end


  context '異常系テスト' do
    it 'クレジットカード情報が必須であること' do
      @order.token = ''
      @order.valid?
      expect(@order.errors.full_messages).to include "Token can't be blank"
    end

    it '郵便番号が必須であること' do
      @order.post_code = ''
      @order.valid?
      expect(@order.errors.full_messages).to include "Post code can't be blank"
    end

    it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
      @order.post_code = '1234567'
      @order.valid?
      expect(@order.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
    end

    it '都道府県が必須であること' do
      @order.delivery_place_id = 0
      @order.valid?
      expect(@order.errors.full_messages).to include "Delivery place can't be blank"
    end

    it '市区町村が必須であること' do
      @order.city = ''
      @order.valid?
      expect(@order.errors.full_messages).to include "City can't be blank"
    end

    it '番地が必須であること' do
      @order.street_address = ''
      @order.valid?
      expect(@order.errors.full_messages).to include "Street address can't be blank"
    end

    it '電話番号は必須であること' do
      @order.telephone = ''
      @order.valid?
      expect(@order.errors.full_messages).to include "Telephone can't be blank"
    end

    it '電話番号が9桁以下の場合は保存が不可能' do
      @order.telephone = '012345678'
      @order.valid?
      expect(@order.errors.full_messages).to include "Telephone is invalid."
    end

    it '電話番号が12桁以上の場合は保存が不可能' do
      @order.telephone = '012345678901'
      @order.valid?
      expect(@order.errors.full_messages).to include "Telephone is invalid."
    end

    it '電話番号が数字以外を含む場合は保存が不可能' do
      @order.telephone = '01234-56789'
      @order.valid?
      expect(@order.errors.full_messages).to include "Telephone is invalid."
    end

    it '電話番号が全角数字の場合は保存が不可能' do
      @order.telephone = '０１２３４５６７８９'
      @order.valid?
      expect(@order.errors.full_messages).to include "Telephone is invalid."
    end

    it 'userが存在しないと購入できない' do
      @order.user_id = nil  # user_idをnilに設定
      @order.valid?
      expect(@order.errors.full_messages).to include("User can't be blank")
    end

    it 'itemが存在しないと購入できない' do
      @order.item_id = nil  # item_idをnilに設定
      @order.valid?
      expect(@order.errors.full_messages).to include("Item can't be blank")
    end

  end
end