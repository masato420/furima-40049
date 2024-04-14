class Order
  include ActiveModel::Model
  attr_accessor :post_code, :delivery_place_id, :city, :street_address, :building_name, :telephone, :purchase, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :delivery_place_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :street_address
    validates :telephone, format: { with: /\A\d{10,11}\z/, message: "is invalid." }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    user = User.find_by(id: user_id)
    item = Item.find_by(id: item_id)

    return false unless user && item

    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Shipping.create(purchase_id: purchase.id, post_code: post_code, delivery_place_id: delivery_place_id, city: city, street_address: street_address, building_name: building_name, telephone: telephone)
  end
end
