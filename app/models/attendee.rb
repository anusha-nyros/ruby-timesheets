class Attendee < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :meetings
  belongs_to :organization
  validates_presence_of :name
end
