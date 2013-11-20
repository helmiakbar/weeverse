class Project < ActiveRecord::Base
	reverse_geocoded_by :lat, :long
	has_and_belongs_to_many :users
	belongs_to :parent, :class_name=>Project
  has_many :childrens, :class_name=>Project,:foreign_key=>"parent_id"

	mount_uploader :image, ImageUploader
end
