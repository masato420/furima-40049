class PurchasesController < ApplicationController
  before_action :set_item, only: [:new, :create]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :redirect_if_sold, only: [:new]
  before_action :redirect_if_seller, only: [:new, :create]

  def create
    @order = Order.new(order_params)
    if @order.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      begin
        Payjp::Charge.create(
          amount: @item.price,
          card: params[:token],
          currency: 'jpy'
        )
        @order.save
        redirect_to root_path
      rescue Payjp::InvalidRequestError => e
        flash[:error] = "決済処理に失敗しました: #{e.message}"
        render :new, status: :unprocessable_entity
      end
    else
      @order.errors.full_messages.each do |message|
        flash.now[:errors] ||= []
        flash.now[:errors] << message
      end
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :new, status: :unprocessable_entity
    end
  end
  
  def new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order = Order.new
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_seller
    if current_user.id == @item.user_id
      redirect_to root_path, alert: "自身が出品した商品の購入ページにはアクセスできません。"
    end
  end

  def order_params
    params.require(:order).permit(:post_code, :delivery_place_id, :city, :street_address, :building_name, :telephone).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def redirect_if_sold
    redirect_to root_path if @item.purchase.present?
  end
end

