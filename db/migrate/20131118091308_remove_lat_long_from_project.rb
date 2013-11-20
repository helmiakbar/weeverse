class RemoveLatLongFromProject < ActiveRecord::Migration
  def change
  	remove_column :projects, :lat, :string
  	remove_column :projects, :long, :string
  end
end
