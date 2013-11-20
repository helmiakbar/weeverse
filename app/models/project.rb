class Project < ActiveRecord::Base
	reverse_geocoded_by :lat, :long
	has_and_belongs_to_many :users
	belongs_to :parent, :class_name=>Project
  has_many :childrens, :class_name=>Project,:foreign_key=>"parent_id"
  has_many :taggings
  has_many :tags, through: :taggings

	mount_uploader :image, ImageUploader

  def self.tagged_with(name)
    Tag.find_by_name!(name).projects
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
