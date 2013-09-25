class Tasktype < ActiveRecord::Base
  attr_accessible :datecreated, :organization_id, :projects_count, :tasktype, :usage
  belongs_to :organization
  has_many :projects
end
