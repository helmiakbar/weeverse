class AddStreetToIdea < ActiveRecord::Migration
  def change
  	add_column :ideas, :street, :string
  end
end
