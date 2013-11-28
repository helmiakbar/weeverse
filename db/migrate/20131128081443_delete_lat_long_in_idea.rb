class DeleteLatLongInIdea < ActiveRecord::Migration
  def change
  	remove_column :ideas, :lat, :string
  	remove_column :ideas, :long, :string
  end
end
