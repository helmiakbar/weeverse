class Addlatlongtoproject < ActiveRecord::Migration
  def change
  	add_column :projects, :lat, :string
  	add_column :projects, :long, :string
  end
end
