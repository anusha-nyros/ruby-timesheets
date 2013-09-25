class Statusreport < ActiveRecord::Base
  belongs_to :organization
  has_and_belongs_to_many :projects
  has_many :line_items
  attr_accessible :report_date, :report_number, :report_time, :send_to,:custom_message, :sent_by, :subject,:report_user,:report_priority
end
