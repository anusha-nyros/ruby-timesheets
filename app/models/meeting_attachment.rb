class MeetingAttachment < ActiveRecord::Base
  attr_accessible :doc, :meeting_id
  mount_uploader :doc, MeetingAttachmentUploader
  
  belongs_to :meeting

end
