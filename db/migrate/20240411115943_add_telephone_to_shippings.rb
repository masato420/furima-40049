class AddTelephoneToShippings < ActiveRecord::Migration[7.0]
  def change
    add_column :shippings, :telephone, :string
  end
end
