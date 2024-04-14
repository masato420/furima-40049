require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    # 購入者と販売者のユーザーを作成
    buyer = FactoryBot.create(:user)
    seller = FactoryBot.create(:user)
    # 商品を作成
    item = FactoryBot.create(:item, user_id: seller.id)
    # 購入情報のインスタンスを生成
    @order = FactoryBot.build(:order, user_id: buyer.id, item_id: item.id)
  end

  it '電話番号が10桁の場合は保存が可能' do
    @order.telephone = '0123456789'
    @order.token = 'tok_abcdefghijk00000000000000000' # ダミーのトークン値を設定
    expect(@order).to be_valid
  end
  
  it '電話番号が11桁の場合は保存が可能' do
    @order.telephone = '01234567890'
    @order.token = 'tok_abcdefghijk00000000000000000' # ダミーのトークン値を設定
    expect(@order).to be_valid
  end

  it 'クレジットカード情報が必須であること' do
    @order.token = nil
    expect(@order).to_not be_valid
  end

  it '郵便番号が必須であること' do
    @order.post_code = nil
    expect(@order).to_not be_valid
  end

  it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
    @order.post_code = '1234567'
    expect(@order).to_not be_valid
  end

  it '都道府県が必須であること' do
    @order.delivery_place_id = nil
    expect(@order).to_not be_valid
  end

  it '市区町村が必須であること' do
    @order.city = nil
    expect(@order).to_not be_valid
  end

  it '番地が必須であること' do
    @order.street_address = nil
    expect(@order).to_not be_valid
  end

  it '電話番号は必須であること' do
    @order.telephone = nil
    expect(@order).to_not be_valid
  end

  it '電話番号は必須であること' do
    @order.telephone = nil
    expect(@order).to_not be_valid
  end

  it '電話番号が10桁の場合は保存が可能' do
    @order.telephone = '0123456789'
    expect(@order).to be_valid
  end

  it '電話番号が11桁の場合は保存が可能' do
    @order.telephone = '01234567890'
    expect(@order).to be_valid
  end

  it '電話番号が9桁以下の場合は保存が不可能' do
    @order.telephone = '012345678'
    expect(@order).to_not be_valid
  end

  it '電話番号が12桁以上の場合は保存が不可能' do
    @order.telephone = '012345678901'
    expect(@order).to_not be_valid
  end

  it '電話番号が数字以外を含む場合は保存が不可能' do
    @order.telephone = '01234-56789'
    expect(@order).to_not be_valid
  end

  it '電話番号が全角数字の場合は保存が不可能' do
    @order.telephone = '０１２３４５６７８９'
    expect(@order).to_not be_valid
  end
end
