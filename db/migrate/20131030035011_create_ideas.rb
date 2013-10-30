class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
