class Project < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :parent, :class_name=>Project
  	has_many :childrens, :class_name=>Project,:foreign_key=>"parent_id"

	mount_uploader :image, ImageUploader
end
