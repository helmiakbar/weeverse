class CreateSocials < ActiveRecord::Migration
  def change
    create_table :socials do |t|
    	t.string 	:title
			t.string 	:description
			t.string 	:image
			t.string 	:country
			t.string 	:city
			t.string 	:postal_code
			t.string 	:creator
			t.integer :project_id
			t.float	 	:lat
			t.float	 	:long
			t.string	:image
			    
	    t.timestamps
    end
  end
end
