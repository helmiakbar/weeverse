class RemoveImageFromSocial < ActiveRecord::Migration
  def change
  	remove_column :socials, :image, :string
  end
end
