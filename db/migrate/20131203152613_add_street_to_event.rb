class AddStreetToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :street, :string
  end
end
