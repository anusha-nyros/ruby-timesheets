class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authorize
    redirect_to login_url,  :alert => "You are not authorized person please make sure that you have an account and then login" unless current_user 
  end
  
 def update_proj_number
  @projects = current_user.organization.project_types(:order=>'created_at ASC')
  @first_proj = current_user.organization.project_types.find(:first,:order=>'created_at ASC')
 if !@projects.blank? && !@first_proj.blank?
  if @first_proj.proj_number.blank?
   puts "going to update the proj_numbers"
  i=1
  @projects.each do |p|
     uniq_id = ("PROJ-%0.5d" %i).to_s
     i = i+1
     p.update_attribute("proj_number", uniq_id)
  end
 end
end
end  


def update_project_id
  @projs= Project.find(:all)
  @projs.each do |pr|
      ptid = ProjectType.find_by_type_name(pr.project_type).try(:id)
      if !ptid.blank?
      pr.update_attribute('project_type_id',ptid) 
      end 
  end
end
  
 def update_created_at
      
    @pt = current_user.organization.project_types(:order => 'created_at ASC')
    @fp = current_user.organization.project_types.find(:first,:order => 'created_at ASC')
    if !@pt.blank? && !@fp.blank?
        
    if @fp.date_created.blank?
        @pt.each do |p|
            p.update_attribute("date_created",p.created_at.to_date)       
        end      
      end    
    end
 end



  def plan_check?
     if !current_user.expiry_date.blank?
        if (DateTime.now >= current_user.expiry_date) && current_user.credit_status == false
         true
        else
	  false	
	end 
        
    else
	if (DateTime.now >= current_user.created_at + 30.days) && current_user.credit_status == false
         true
    	else
      	false
    	end 
   end
end 
def admin_credit_check(user)

    if user.organization.credit_status == true 

      true  
    else
      if !user.organization.expiry_date.blank?
          if  (DateTime.now >= user.organization.expiry_date)
           false
           else
            true
          end 
         
     else
           if  (DateTime.now >= user.organization.created_at + 30.days)
               false 
           else
              true
           end 
     end 
    end   
end


def change_creditcard_date(date)
    date_array = date.split("/")
    date_array[2]="01"
    new_date = date_array[1]+"/"+date_array[0]+"/"+date_array[2]
    puts new_date.inspect
    return new_date
 end

def plan_check1
   if current_user.admin?
     if !current_user.expiry_date.blank?
       if (DateTime.now >= current_user.expiry_date) && current_user.credit_status == false
         redirect_to new_creditcard_path
        end 
    else
    if (DateTime.now >= current_user.created_at + 30.days) && current_user.credit_status == false
      redirect_to new_creditcard_path
    end
   end 
 end 
end 

def admin_credit_check1
    if current_user.organization.credit_status == false
       redirect_to login_url, :alert => "Please log in first!" unless current_user 
  end   
end



  def check_account_type_project
    redirect_to root_url, :alert => "Your account is not a project" unless current_user.organization.account_type == "project"
  end
  def update_prq_number
  @prq_projects = current_user.organization.projects(:order=>'created_at ASC')
  @prq_pro = current_user.organization.projects.find(:first,:order=>'created_at ASC')
 
 
 if !@prq_projects.blank? && !@prq_pro.blank?
  if @prq_pro.prq_number.blank?
   puts "going to update the prq numbers"
  
  i=1
  @prq_projects.each do |p|
    #unless p.prq_number.blank?
     uniq_id = ("PRQ-%0.5d" %i).to_s
    puts uniq_id
    i = i+1
    p.update_attribute("prq_number", uniq_id)
    #end
 end
  end
  end
end  

#update timesheet number

def update_timesheet_number
 
  @timesheet = current_user.organization.pay_periods(:order=>'created_at ASC')
  @first_ts = current_user.organization.pay_periods.find(:first,:order=>'created_at ASC')
 
 
 if !@timesheet.blank? && !@first_ts.blank?
  if @first_ts.timesheet_number.blank?
   puts "going to update the timesheet_numbers"
  
  i=1
  @timesheet.each do |t|
    
     uniq_id = ("TIME-%0.5d" %i).to_s
    puts uniq_id
    i = i+1
    t.update_attribute("timesheet_number", uniq_id)
    
 end
  end
  end
end  



#for changing the date format in to mm/yy/dd while creating time
 def change_date_format(date)
    if date.include? '/'
	    date_array = date.split("/")
	    new_date = date_array[1]+"/"+date_array[2]+"/"+date_array[0]
 		puts new_date
     	    return new_date
    else
    	    return date
    end
  end

#for calculating varinca and percent variance
def update_variance


  @var_projects = current_user.organization.projects(:order=>'updated_at DESC')
 
  @var_projects.each do |v|
    if v.amount != 0
     spent = v.time_records.sum(:total_hours)
     #if spent != 0 && v.amount !=0
     varce = v.amount - spent
      var_per= ((varce/v.amount)*100).round(2)
      v.record_timestamps=false
     v.update_attribute("variance",varce)
     v.update_attribute("percent_variance",var_per)
     v.record_timestamps=true
    # end
    end
  end

end   #end update_variance


#fill amount with  zeroes
def fill_amount
@fill_projects= current_user.organization.projects
  @fill_projects.each do |p|
    if p.amount.blank?
     amt= 0.0     
     p.record_timestamps=false
    p.update_attribute("amount",amt)
    p.record_timestamps=true
    end  
 end

end #end fill amount

#fill amount with  zeroes
def fill_actual
@fill_act= current_user.organization.projects
  @fill_act.each do |fp|
    actual_amt= fp.time_records.sum(:total_hours)
    #if actual_amt !=0
     fp.record_timestamps=false
    fp.update_attribute("actual",actual_amt)
    fp.record_timestamps=true
    #end  
 end

end #end fill actual
#for user tabs1
def update_switches
if !current_user.admin?
 @tabs = Array.new
@tabs1 = Array.new
@mod = Array.new
    @tab1 = current_user.orgtabs

@tab1.each do |id|
   @tabs << id.tabname
	end

@tabs.each do  |tab|
@mod <<  SwitchTab.find_by_module_name_and_user_value(tab,current_user.id)

if !@mod.any?
@item = SwitchTab.create
@item.module_name = tab.to_s
@item.user_value = current_user.id

@item.save
end
 @mod.clear 
end 

end
end 
#end for user tabs

# for history 
def change_date_form(date)

     
     date_array = date.to_s.split("-")
    puts date_array
    new_date = date_array[2]+ "/" + date_array[0] + "/" + date_array[1]
    puts new_date.inspect
    return new_date

  end
def bulk_change_date_form(date)

     
     date_array = date.to_s.split("/")
    puts date_array
    new_date = date_array[2]+ "-" + date_array[0] + "-" + date_array[1]
    puts new_date.inspect
    return new_date

  end
def change_active(act_val)
  @act_val = act_val.to_s
if @act_val == "true"
     @act_val = 1
     return @act_val
else
     @act_val = 0
     return @act_val

 end
 
end

#//for history

def fill_actual_new(pro_id)

@pjct = pro_id
@fill_act= Project.find_by_sql("select * from projects where id ='#{@pjct}'")
@fill_act.each do |fp|
actual_amt= fp.time_records.sum(:total_hours)
fp.record_timestamps=false
fp.update_attribute("actual",actual_amt)
fp.record_timestamps=true
end 

 end 
def update_variance_new(pro_id)
@pjct = pro_id
  @var_projects = Project.find_by_sql("select * from projects where id ='#{@pjct}'")
  @var_projects.each do |v|
    if v.amount != 0
     spent = v.time_records.sum(:total_hours)
     #if spent != 0 && v.amount !=0
     varce = v.amount - spent
      var_per= ((varce/v.amount)*100).round(2)
      v.record_timestamps=false
     v.update_attribute("variance",varce)
     v.update_attribute("percent_variance",var_per)
     v.record_timestamps=true
    # end
    end
  end

end 

def update_all_prqs
@prq_projects = Project.with_deleted.find(:all)
@prq_projects.each do |p|
v = p.prq_number.gsub("PRQ","TASK")
p.record_timestamps= false
p.update_attribute("prq_number",v)
p.record_timestamps= true
end 
end 

def update_all_prq_line
@prq_projects = LineItem.find(:all)
@prq_projects.each do |p|
v = p.prq_number.gsub("PRQ","TASK")
p.record_timestamps= false
p.update_attribute("prq_number",v)
p.record_timestamps= true
end 
end 


end
