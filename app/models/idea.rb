class Idea < ActiveRecord::Base
	mount_uploader :image, ImageUploader
end
