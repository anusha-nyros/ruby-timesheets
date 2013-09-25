class Orgtab < ActiveRecord::Base
  attr_accessible :tabname
  has_and_belongs_to_many :users
end
