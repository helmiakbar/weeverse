class AddStreetToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :street, :string
  end
end
