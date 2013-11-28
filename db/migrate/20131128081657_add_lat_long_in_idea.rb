class AddLatLongInIdea < ActiveRecord::Migration
  def change
	add_column :ideas, :lat, :float
  	add_column :ideas, :long, :float
  end
end
