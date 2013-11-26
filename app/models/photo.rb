class Photo < ActiveRecord::Base
	belongs_to :social
	
	mount_uploader :image, MediaUploader
end
