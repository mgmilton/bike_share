class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.integer :status, default: 0
      t.text :description
      t.decimal :price
    end
  end
end
