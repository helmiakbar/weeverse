class Event < ActiveRecord::Base
	reverse_geocoded_by :lat, :long
	has_many	:ideas
	has_many	:socials

	mount_uploader :image, ImageUploader
end
