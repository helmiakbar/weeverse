class Social < ActiveRecord::Base
	belongs_to :project
  has_many :media_urls
	mount_uploader :image, MediaUploader

  accepts_nested_attributes_for :media_urls
end
