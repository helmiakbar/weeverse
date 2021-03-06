class Idea < ActiveRecord::Base
  reverse_geocoded_by :lat, :long
  belongs_to :project
  belongs_to :event
  has_many :taggings
  has_many :tags, through: :taggings
	mount_uploader :image, ImageUploader

	def self.tagged_with(name)
    Tag.find_by_name!(name).ideas
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
