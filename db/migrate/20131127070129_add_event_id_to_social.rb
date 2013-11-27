class AddEventIdToSocial < ActiveRecord::Migration
  def change
  	add_column :socials, :event_id, :integer
  end
end
