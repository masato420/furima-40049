class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :redirect_unless_owner, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold, only: [:edit, :update, :destroy]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
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

  def destroy
    if @item.destroy
      redirect_to items_path, notice: 'Item was successfully destroyed.'
    else
      redirect_to @item, alert: 'Something went wrong. The item could not be destroyed.'
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :explanation, :category_id, :condition_id, :delivery_charge_id, :delivery_place_id, :delivery_day_id, :price, :image)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_unless_owner
    redirect_to root_path, alert: 'アクセス権限がありません' unless current_user.id == @item.user_id
  end

  def redirect_if_sold
    if @item.sold?
      redirect_to root_path, alert: "この商品は既に売却済みです。"
    end
  end
end