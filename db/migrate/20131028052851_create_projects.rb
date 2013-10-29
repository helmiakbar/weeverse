class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.string :address
      t.string :image
      t.string :creator

      t.timestamps
    end
  end
end
