class RemoveAddressFormUser < ActiveRecord::Migration
  def change
  	remove_column :users, :address, :string
  end
end
