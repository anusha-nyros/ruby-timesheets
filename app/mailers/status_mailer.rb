class StatusMailer < ActionMailer::Base
  #default from: "ayraju007@gmail.com"

#****************sending emails for every status in the app******************

def send_email(mya,myemails1,rep_number,creator_name,custom_message,msg)
    @message=msg
     @custom_message = custom_message
    @projects = mya
    @rep_number = rep_number
    @creator_name = creator_name
    mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => myemails1,
         :subject => " #{@rep_number} - Status Report  #{Date.today.strftime('%m-%d-%Y')} - #{@creator_name} ",
         :date => Time.now
        )
  end

  def issue_email(myemails,mya,msg)
    @message = msg
    @issues = mya
    mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => myemails,
         :subject => "Issue Email",
         :date => Time.now
        )
  end
  
  
  def time_record_email(myemails,mya,msg)
    
    @time_records = mya
    @message = msg
    mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => myemails,
         :subject => "Time Records Email",
         :date => Time.now
        )
  end
  
  def expense_email(myemails,mya)
    
    @expenses = mya
    mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => myemails,
         :subject => "Expenses Email",
         :date => Time.now
        )
  end

def send_email1(mya,myemails1,rep_number,creator_name,custom_message,msg)
    @message = msg
    @custom_message = custom_message
    @projects = mya
    @rep_number = rep_number
    @creator_name = creator_name
    mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => myemails1,
         :subject => " #{@rep_number} - Status Report  #{Date.today.strftime('%m-%d-%Y')} - #{@creator_name} ",
         :date => Time.now
        )
  end

 def send_detail_view_email(myemails1,time_records,pay_period,tot_hrs,cur_admin,curr_user,msg)
    @message = msg
    @curr_user = curr_user
    @time_records = time_records
    @pay_period = pay_period
    @tot_hrs = tot_hrs
    @cur_admin = cur_admin
    mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => myemails1,
         :subject => " Time Sheet Detail View ( #{@pay_period.pay_start.strftime("%d %b")} - #{@pay_period.pay_end.strftime("%d %b")}) -- #{@curr_user}",
         :date => Time.now
        )
  end

  def send_user_recap_email(myemails1,user_time_records,pay_period,curr_user,msg)
    @message = msg
    @curr_user = curr_user
    @user_time_records = user_time_records
    @pay_period = pay_period
    mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => myemails1,
         :subject => " Time Sheet User Recap View - Users( #{@pay_period.pay_start.strftime("%d %b")} - #{@pay_period.pay_end.strftime("%d %b")}) -- #{@curr_user}",
         :date => Time.now
        )    
  end

  def send_project_recap_email(myemails1,user_time_records,pay_period,curr_user,msg)
    @curr_user = curr_user
    @user_time_records = user_time_records
    @pay_period = pay_period
    @message = msg
    mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => myemails1,
         :subject => " Time Sheet Project Recap View - Projects( #{@pay_period.pay_start.strftime("%d %b")} - #{@pay_period.pay_end.strftime("%d %b")}) -- #{@curr_user}",
         :date => Time.now
        )    
  end


def feedback(first_name,last_name,email,message,company_name,msgtype)
@first_name = first_name
@last_name = last_name
@email = email
@message = message
@company_name = company_name
   mail(:from => "Team Cloud <noreply@goteamcloud.com>",
         #:to => "info@teamcloudhq.com",
         :to => "ratnakarrao_nyros@yahoo.com",
         #:cc => "ruben.vila@ymail.com",
         :cc => "ratnakarrao_nyros@yahoo.com",
         :subject => msgtype,
         :date => Time.now)

end

def thanks_feedback_email(first_name,last_name,email)
@first_name = first_name
@last_name = last_name
@email = email

   mail(:from => "Team Cloud <noreply@goteamcloud.com>",
         #:to => email,
         :to => "ratnakarrao_nyros@yahoo.com",
         :subject => "Thank You  ",
         :date => Time.now)

end 





def notification_issue_mail(emails,issue)
@issue = issue 
   mail(:from => "Team Cloud <noreply@goteamcloud.com>",
         :to => emails,
         :subject => "Issue Notification -- #{@issue.issue_number} ",
         :date => Time.now)
end 

def notification_task_mail(emails,project)
@project = project 
   mail(:from => "Team Cloud <noreply@goteamcloud.com>",
         :to => emails,
         :subject => "Task Notification -- #{@project.prq_number} ",
         :date => Time.now)
end 
def notification_project_type_mail(emails,project,val1,proj_contact_emails)
@project = project 
@emails = emails
@proj_contact_emails = proj_contact_emails
@val1 = val1

   mail(:from => "Team Cloud <noreply@goteamcloud.com>",
         :to => emails,
         :subject => "Project Update  Notification -- #{@project.proj_number} ",
         :date => Time.now)


end 


def welcome_email(umail)
@user = umail
   mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => umail.email,
         :subject => "Status List Details ",
         :date => Time.now)

end

def test_email
   @user = User.find(45)
   mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => @user.email,
         :subject => "Cron Job Testting ",
         :date => Time.now)
end

def reminder_email_week1(user)
  @user = user 
   mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => @user.email,
         :subject => "Reminder Email",
         :date => Time.now)
end
def reminder_email_week2(user)
    @user = user 
   mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => @user.email,
         :subject => "Reminder Email ",
         :date => Time.now)
end
def reminder_email_week3(user)
    @user = user 
   mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to => @user.email,
         :subject => "Reminder Email ",
         :date => Time.now)
end
def invite_users(user,to,subject)
  @user=user
  @subject = subject
 mail(:from => "Team Cloud<noreply@goteamcloud.com>",:to => to ,:subject => "Invitation to join into goteamcloud" ,:date => Time.now) 
end

def email_project_transactions(email_projects,emails,msg)
@email_projects = email_projects
@emails = emails
@message = msg
  mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to =>emails,
         :subject => "Project Transactions",
         :date => Time.now)
end

def email_task_transactions(email_tasks,emails,msg)
@email_tasks = email_tasks
@emails = emails
@message = msg
  mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to =>emails,
         :subject => "Task Transactions",
         :date => Time.now)
end 

def email_pdf(email,msg,lineitem)

attachments["pdf_report_#{lineitem.id}.pdf"] = File.read("#{Rails.root}/public/pdf_report_#{lineitem.id}.pdf")
@headers = {}

mail(:from =>"Team Cloud<noreply@goteamcloud.com>",
         :to =>email,
         :subject => "Invoice Pdf",
         :date => Time.now,
         :body => msg)

end 
    
end
