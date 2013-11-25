class CreateMediaUrls < ActiveRecord::Migration
  def change
    create_table :media_urls do |t|
      t.string :url
      t.integer :social_id

      t.timestamps
    end
  end
end
