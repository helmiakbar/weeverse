class Social < ActiveRecord::Base
	belongs_to :project
	mount_uploader :image, MediaUploader
end
