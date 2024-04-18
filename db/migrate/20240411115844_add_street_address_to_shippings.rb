class AddStreetAddressToShippings < ActiveRecord::Migration[7.0]
  def change
    add_column :shippings, :building_name, :string
  end
end
