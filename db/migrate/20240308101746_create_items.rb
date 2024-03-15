class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string  :item_name,           null: false, default: ""
      t.text    :explanation,         null: false, default: ""
      t.integer :category_id,         null: false
      t.integer :condition_id ,       null: false
      t.integer :delivery_charge_id,  null: false
      t.integer :delivery_place_id ,  null: false
      t.integer :delivery_day_id,     null: false
      t.integer :price,               null: false
      t.references :user,             null: false, foreign_key: true

      t.timestamps
    end
  end
end
