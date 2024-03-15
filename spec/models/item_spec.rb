require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '新規登録' do
    context '全ての項目が存在すれば登録できる' do
      it 'is valid with all attributes' do
        expect(@item).to be_valid
      end
    end

    context '必須項目が欠けている場合は登録できない' do
      it '商品名が空だと登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it '説明が空だと登録できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end

      it 'category_idが1の場合は登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'condition_idが1の場合は登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it 'delivery_charge_idが1の場合は登録できない' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge can't be blank")
      end

      it 'delivery_place_idが1の場合は登録できない' do
        @item.delivery_place_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery place can't be blank")
      end

      it 'delivery_day_idが1の場合は登録できない' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      end

      it '価格が空だと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      describe '価格のバリデーション' do
        it '価格が300円以上であれば有効であること' do
          @item.price = 300
          expect(@item).to be_valid
        end
    
        it '価格が9,999,999円以下であれば有効であること' do
          @item.price = 9999999
          expect(@item).to be_valid
        end
    
        it '価格が300円未満では無効であること' do
          @item.price = 299
          @item.valid?
          expect(@item.errors[:price]).to include("must be greater than or equal to 300")
        end
    
        it '価格が9,999,999円を超えると無効であること' do
          @item.price = 10000000
          @item.valid?
          expect(@item.errors[:price]).to include("must be less than or equal to 9999999")
        end
    
        it '価格が半角数値でない場合無効であること' do
          @item.price = '三百円'
          @item.valid?
          expect(@item.errors[:price]).to include("is not a number")
        end
      end

      describe 'アソシエーションの検証' do
        context 'userが紐づいていない場合' do
          it '登録できないこと' do
            item = FactoryBot.build(:item, user: nil)
            item.valid?
            expect(item.errors[:user]).to include("must exist")
          end
        end
      end
    end
  end
end