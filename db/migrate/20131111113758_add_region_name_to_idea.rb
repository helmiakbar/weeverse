class AddRegionNameToIdea < ActiveRecord::Migration
  def change
  	add_column :ideas, :region_name, :string
  end
end
