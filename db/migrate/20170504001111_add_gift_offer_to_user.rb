class AddGiftOfferToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :gift_offer, :bool, default: false
  end
end
