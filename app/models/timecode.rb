class Timecode < ActiveRecord::Base
  attr_accessible :code, :usage
  validates_presence_of :code
belongs_to :organization
end
