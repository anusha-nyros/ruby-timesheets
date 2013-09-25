class Skill < ActiveRecord::Base
  attr_accessible :name, :organization_id
  has_and_belongs_to_many :contacts
  belongs_to :organization
  validates_presence_of :name
end
