class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string 	:title
			t.string 	:description
			t.string 	:image
			t.string 	:country
			t.string 	:city
			t.string 	:postal_code
			t.string 	:creator
			t.float	 	:lat
			t.float	 	:long
			t.string	:image
			t.date		:date
    end
  end
end
