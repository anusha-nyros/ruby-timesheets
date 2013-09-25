require 'active_support/all'
class Admin::HomeController < Admin::AdminController
  before_filter :plan_check1
  def index
  
  contact = User.find_by_id(current_user)
       @calendars = contact.calendars.find(:all, :conditions => "entry_date != 0" )
       @date = params[:month] ? Date.parse(params[:month]) : Date.today
       if @calendars.count == 0
       flash.now[:notice] = "You Have Not Any Activities. Please Schedule Your Activities."
       end
   @over_budget = current_user.organization.projects.find(:all, :conditions => ['variance < ?',0])
   @active_projects = current_user.organization.project_types.find(:all, :conditions => {:Status => 'Active'})
   @active_tasks = current_user.organization.projects.find(:all,:conditions => {:active => 1 }, :order => 'updated_at DESC')
   @past_due_tasks = current_user.organization.projects.find(:all, :conditions => ['active = ? AND schedule_date < ? AND action_required =?',1,Date.today,'In Progress'])
   @projects = current_user.organization.project_types.find(:all)
   @q = current_user.organization.projects.search(params[:q])
   @q1 = current_user.organization.issues.search(params[:q])

  # for over budget expenses 
   @over_projct_expense = []
    @projects.each do |k| 
    @budget = Payment.find(:all ,:conditions => {:project_type_id => k.id }).sum(&:pay_amount) 
     if @budget > k.expense_budget
      @over_projct_expense << k
     end
     end 
@bug = 0   
if @over_projct_expense.count !=0
     @over_projct_expense.each do |j|
   @bug += j.issues.count
   end
   else
   @bug = 0
   end
    
   @active_issues = current_user.organization.issues.find(:all,:conditions => {:active => 1 }, :order => 'updated_at DESC')
   @open_timesheets = current_user.organization.pay_periods.find(:all, :conditions => {:status => 'Open' })
   @past_due_projects = current_user.organization.project_types.find(:all, :conditions => ['status =? AND end_date < ?','Pending',Date.today])

   @upcoming_meetings = current_user.organization.meetings.find(:all, :conditions => ['meeting_date > ?',Date.today])
   @documents_checked_out = current_user.organization.activities.find(:all, :conditions => {:doc_check => '1'})
   @open_threads = current_user.organization.my_threads.find(:all)
   @sr_wait_to_sent = current_user.organization.statusreports.find(:all, :conditions => ['sent_by IS ?',nil])
   @expenses_pending = current_user.organization.expenses.find(:all, :conditions => {:status => '0'})
   @today_schedule_tasks = current_user.organization.projects.find(:all, :conditions => ['schedule_date = ?',Date.today])
   @week_schedule_tasks = current_user.organization.projects.find(:all, :conditions=>{:schedule_date => DateTime.now.beginning_of_week..DateTime.now.end_of_week})
   @this_month_schedule_tasks = current_user.organization.projects.find(:all,:conditions=>{:schedule_date => DateTime.now.beginning_of_month..DateTime.now.end_of_month})
   @next_week_schedule = current_user.organization.projects.find(:all, :conditions=>{:schedule_date => DateTime.now.next_week.beginning_of_week..DateTime.now.next_week.end_of_week})
   @next_month_schedule = current_user.organization.projects.find(:all, :conditions=>{:schedule_date => DateTime.now.next_month.beginning_of_month..DateTime.now.next_month.end_of_month})
   @last_week_schedule  = current_user.organization.projects.find(:all, :conditions => {:schedule_date => 
   (DateTime.now - 1.week).beginning_of_week..(DateTime.now - 1.week).end_of_week})
   @last_month_schedule  = current_user.organization.projects.find(:all, :conditions => {:schedule_date => 
   (DateTime.now - 1.month).beginning_of_month..(DateTime.now - 1.month).end_of_month})
   @recent_activityof_task = current_user.organization.projects.includes(:time_records).find(:all, :joins => [:time_records], :conditions=>{:schedule_date => DateTime.now.beginning_of_week..DateTime.now.end_of_week})
   @timesheets_pending_approval = current_user.organization.pay_periods.find(:all, :conditions =>{:status => 'Pending'})
   
  end

 def search_task
    @q = current_user.organization.projects.search(params[:q])
    if params[:q]
      @projects = @q.result(:distinct  => true).page(params[:page])   if params[:q]
   end
   respond_to do |format|
      format.html
      format.json { head :no_content }
    end
end 

def search_issue
    @q1 = current_user.organization.issues.search(params[:q])
    if params[:q]
      @issues = @q1.result(:distinct  => true).page(params[:page])  if params[:q]
    end
respond_to do |format|
      format.html
      format.json { head :no_content }
    end   
end



end
