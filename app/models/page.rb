class Page < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :message, :company_name
 validates :email, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
 validates_presence_of :first_name
 validates_presence_of :last_name
 validates_presence_of :message
end
