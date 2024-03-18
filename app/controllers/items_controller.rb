class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update]
  before_action :set_item, only: [:edit, :update, :show]
  before_action :redirect_unless_owner, only: [:edit, :update]

  def index
    @items = Item.order("created_at DESC")
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

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_unless_owner
    unless current_user.id == @item.user_id
      redirect_to root_path, alert: 'アクセス権限がありません'
    end
  end

  def item_params
    params.require(:item).permit(:image, :item_name, :explanation, :category_id, :condition_id, :delivery_charge_id, :delivery_place_id, :delivery_day_id, :price).merge(user_id: current_user.id)
  end

end
