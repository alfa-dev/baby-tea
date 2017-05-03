class AddEnabledToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :enabled, :bool, :default => true
  end
end
