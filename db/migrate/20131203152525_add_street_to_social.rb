class AddStreetToSocial < ActiveRecord::Migration
  def change
  	add_column :socials, :street, :string
  end
end
