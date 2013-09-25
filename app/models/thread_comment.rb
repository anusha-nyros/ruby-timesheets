class ThreadComment < ActiveRecord::Base
  attr_accessible :my_thread_id, :title
  belongs_to :my_thread
  belongs_to :user
  belongs_to :organization
  
  validates_presence_of :title
end
