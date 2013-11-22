class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :project
  belongs_to :idea
end
