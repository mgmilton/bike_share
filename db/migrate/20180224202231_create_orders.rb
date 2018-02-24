class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.float :total
      t.integer :status, default: 0
      t.timestamps
      t.references :user, foreign_key: true
    end
  end
end
