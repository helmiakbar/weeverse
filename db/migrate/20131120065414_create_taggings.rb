class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :project, index: true
      t.belongs_to :idea, index: true

      t.timestamps
    end
  end
end
