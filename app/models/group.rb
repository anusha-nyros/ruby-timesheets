class Group < ActiveRecord::Base
  attr_accessible :organization_id, :title
  has_and_belongs_to_many :contacts
  belongs_to :organization
  validates_presence_of :title
end
