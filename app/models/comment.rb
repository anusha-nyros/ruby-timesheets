class Comment < ActiveRecord::Base
  attr_accessible :coment, :project_id,:uname
  belongs_to :project
  validates_presence_of :coment
end
