class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    #@items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
      if @item.save
        redirect_to root_path, notice: 'Item was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :explanation, :category_id, :condition_id, :delivery_charge_id, :delivery_place_id, :delivery_day_id, :price).merge(user_id: current_user.id)
  end

end
