class AddDeliveryPlaceIdToShippings < ActiveRecord::Migration[7.0]
  def change
    add_column :shippings, :delivery_place_id, :integer
  end
end
