class Status < ActiveRecord::Base
  attr_accessible :status_name, :usage
validates_presence_of :status_name
belongs_to :organization
end
