class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
    	t.string :image
    	t.integer	:social_id
    	t.boolean	:default

  		t.timestamps
    end
  end
end
