class Add < ActiveRecord::Migration
  def change
  	add_column :ideas, :lat, :string
  	add_column :ideas, :long, :string
  	add_column :ideas, :country, :string
  	add_column :ideas, :city, :string
  	add_column :ideas, :postal_code, :string
  	add_column :ideas, :creator, :string
  end
end
