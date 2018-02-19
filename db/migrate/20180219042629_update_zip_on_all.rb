class UpdateZipOnAll < ActiveRecord::Migration[5.1]
  def change
    remove_column :conditions, :zip_code, :integer
    remove_column :trips, :zip_code, :integer
    add_column :conditions, :zip_code, :string
    add_column :trips, :zip_code, :string
  end
end
