class Meeting < ActiveRecord::Base
 belongs_to :supplier, :class_name => "Contact", :foreign_key => "contact_id"
  attr_accessible :action_items, :meeting_date, :meeting_location, :meeting_notes, :supplier_id, :meeting_number, :meeting_time,
                  :subject, :attendee_ids, :to_meeting_time, :meeting_type,:meeting_tool ,:meeting_connection,:meeting_attnds
  belongs_to :organization
  alias_attribute :supplier_id, :contact_id
  has_many :meeting_attachments, :dependent => :destroy
  attr_accessible :meeting_attachments_attributes
  
  accepts_nested_attributes_for :meeting_attachments, :allow_destroy => true
  validates_presence_of :supplier_id
  
  has_and_belongs_to_many :attendees
end
