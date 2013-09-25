class Issue < ActiveRecord::Base
  attr_accessible :active, :description, :issuetype_id, :project_id, :project_type_id, :title ,:owner,:issue_number ,:date_created
  belongs_to :project
  belongs_to :organization
   belongs_to :issuetype
   belongs_to :project_type
   validates_presence_of :project_type_id
   
   
   has_many :issueattachments, :dependent => :destroy
   attr_accessible :issueattachments_attributes
  
  accepts_nested_attributes_for :issueattachments, :allow_destroy => true
end
