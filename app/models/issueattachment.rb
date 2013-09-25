class Issueattachment < ActiveRecord::Base

  attr_accessible :issue_attach, :issue_id
  mount_uploader :issue_attach, IssueAttachUploader 
  belongs_to :issue
  
end
