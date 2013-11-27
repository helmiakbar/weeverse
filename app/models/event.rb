class Event < ActiveRecord::Base
	has_many	:ideas
	has_many	:socials

	mount_uploader :image, ImageUploader
end
