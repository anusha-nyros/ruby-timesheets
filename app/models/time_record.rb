class TimeRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :pay_period
  
  belongs_to :project
  
  attr_accessible :activity_date, :description, :total_hours, :project_id

  validates_presence_of :activity_date
  validates_presence_of :description
  validates :total_hours, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 24 }
  
  validate :activity_date_should_be_within_pay_period, :total_hours_should_be_less_then_24_per_day
 #********************validating methods***************** 
  def activity_date_should_be_within_pay_period
    errors.add(:activity_date, "Could not be empty") and return if activity_date.nil?
    errors.add(:activity_date, "has no pay period associated with") and return if pay_period.nil?
    
    if activity_date < pay_period.pay_start || activity_date > pay_period.pay_end
      errors.add(:activity_date, "can't be outside of pay period")
    end
  end
  
  def total_hours_should_be_less_then_24_per_day
    errors.add(:total_hours, "Could not be empty") and return if total_hours.nil?
     
    daily_total_hours = pay_period.time_records.where('user_id = ? AND activity_date = ?', user, activity_date)
    
    unless id.nil?
      daily_total_hours = daily_total_hours.where('time_records.id != ?', id)
    end
    
    daily_total_hours = daily_total_hours.sum('total_hours')
    
    if total_hours + daily_total_hours > 24 
      errors.add(:total_hours, "can't be more than 24 hours a day, currently is #{daily_total_hours}")
    end
  end
end
