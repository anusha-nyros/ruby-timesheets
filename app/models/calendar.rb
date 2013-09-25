class Calendar < ActiveRecord::Base
  attr_accessible :entry_date, :event, :activity, :cal_num
  belongs_to :user
  belongs_to :organization
end
