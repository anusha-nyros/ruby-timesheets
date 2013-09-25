class PayPeriod < ActiveRecord::Base
  has_many :time_records, dependent: :destroy
  belongs_to :organization
  belongs_to :project
  
  
  attr_accessible :pay_start, :pay_end, :pay_day, :active,:project_id, :timecode, :timesheet_number, :status
  attr_accessible :pay_start, :pay_end, :pay_day, :active,:project_id, :organization, as: :admin

  validates_presence_of :pay_start
  validates_presence_of :pay_end
    
  def total_hours(user = nil )
    if user
      time_records.where(user_id: user).sum('total_hours')
    else
      time_records.sum('total_hours')
    end
  end
  
  # return #<name: 'User name', total:'2.0'>
  def user_with_total_hours
    time_records.select('users.name as name, sum(total_hours) as total').joins('INNER JOIN users on users.id = time_records.user_id').group('users.name')
  end
  
end