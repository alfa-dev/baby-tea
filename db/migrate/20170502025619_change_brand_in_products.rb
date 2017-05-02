class ChangeBrandInProducts < ActiveRecord::Migration[5.0]
  def change
  	change_column :products, :brand, :string
  end
end
