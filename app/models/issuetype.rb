class Issuetype < ActiveRecord::Base
  attr_accessible :issuetype, :organization_id, :usage
  belongs_to :organization
  validates_presence_of :issuetype
end
