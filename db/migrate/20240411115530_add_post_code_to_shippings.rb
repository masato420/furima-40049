class AddPostCodeToShippings < ActiveRecord::Migration[7.0]
  def change
    add_column :shippings, :city, :string
  end
end
