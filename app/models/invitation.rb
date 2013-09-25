class Invitation < ActiveRecord::Base
  attr_accessible :description, :send_to, :user_id, :username 
  validates_presence_of :send_to
  belongs_to :user
end
