class Social < ActiveRecord::Base
	belongs_to :project
  has_many :media_urls
  has_many :photos
  belongs_to :event
	
  accepts_nested_attributes_for :media_urls
end
