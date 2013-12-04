class AddCategoryToSocial < ActiveRecord::Migration
  def change
  	add_column :socials, :category, :string
  end
end
