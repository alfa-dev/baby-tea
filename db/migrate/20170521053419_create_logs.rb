class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.integer :user_id
      t.string :action
      t.integer :product_id  

      t.timestamps
    end
  end
end
