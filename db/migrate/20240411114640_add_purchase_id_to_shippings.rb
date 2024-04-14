class AddPurchaseIdToShippings < ActiveRecord::Migration[7.0]
  def change
    add_column :shippings, :purchase_id, :integer
  end
end
