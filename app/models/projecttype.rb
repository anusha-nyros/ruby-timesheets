class Projecttype < ActiveRecord::Base
  attr_accessible :organization_id, :projecttype, :usage
  belongs_to :organization
  has_many :project_types
  validates_presence_of :projecttype
end
