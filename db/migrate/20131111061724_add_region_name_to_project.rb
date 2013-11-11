class AddRegionNameToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :region_name, :string
  end
end
