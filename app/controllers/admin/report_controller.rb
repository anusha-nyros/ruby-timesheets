class Admin::ReportController < Admin::AdminController
  def index
   if params[:FILTER] == "ALL"
        @pay_periods = current_user.pay_periods.order('pay_start desc').find(:all)
         
        @chosen = "ALL"
   elsif params[:FILTER] == "Inactive"
       @pay_periods = current_user.pay_periods.order('pay_start desc').find(:all, :conditions => {:active => 0 })
       
       @chosen = "Inactive"
  elsif params[:FILTER] == "Active"
        @pay_periods = current_user.pay_periods.order('pay_start desc').find(:all, :conditions => {:active => 1 })
        
        @chosen = "Active"
   elsif params[:FILTER].blank?

    @pay_periods = current_user.pay_periods.order('pay_start desc').find(:all, :conditions => {:active => 1 })
    @chosen = "Active"
    end
  end

  def show
    @pay_period = current_user.pay_periods.find(params[:pay_period_id])
    @user_time_records = @pay_period.user_with_total_hours
  end 

  def details
    @pay_period = current_user.pay_periods.find(params[:pay_period_id])
    @user_time_records = @pay_period.time_records.joins(:user).order('users.name desc').group_by { |rec| rec.user }
  end
end
