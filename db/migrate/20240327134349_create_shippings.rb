class CreateShippings < ActiveRecord::Migration[7.0]
  def change
    create_tabl    :shippings do |t|
      t.string     :post_code,           null: false
      t.integer    :delivery_place_id,   null: false
      t.string     :city,                null: false
      t.string     :street_address,      null: false
      t.string     :building_name,       null: false
      t.string     :telephone,           null: false
      t.references :purchase,            null: false, foreign_key: true

      t.timestamps
    end
  end
end
