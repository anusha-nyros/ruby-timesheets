module ApplicationHelper
  def alert_class(type)
    {:error => "alert-error", :notice => "alert-success", :alert => "alert-info"}[type]
  end
  
  def menu_active(controller_name)
    "active" if controller.controller_path == controller_name
  end
  
   def breadcrumb
    if controller.controller_path != "time_records_search"
    s = ""
    url = request.path.split('?')  #remove extra query string parameters
    levels = url[0].split('/') #break up url into different levels
    if levels.blank?
      s += "<li class='active'>Home</li>\n"
    else
      levels.each_with_index do |level, index|
        unless level.blank?
          if index == levels.size-1 || 
             (level == levels[levels.size-2] && levels[levels.size-1].to_i > 0)
            s += "<li class='active'>#{level.gsub(/_/, ' ').capitalize}</li>\n" unless level.to_i > 0
          else
              link = "/"
              i = 1
              while i <= index
                link += "#{levels[i]}/"
                i+=1
              end
              s += "<li><a href=\"#{link}\">#{level.gsub(/_/, ' ').capitalize}<span class='divider'>/</span></a></li>\n"
          end
        end
      end
    end
    s
    else 
     s= "TimeRecordsSearch"
   end
  end
  def tab_active(controller_name)
    "active" if controller.controller_path == controller_name
  end
  def action_active(action_name)
    "active" if controller.action_name == action_name
  end
  def change_creditcard_date_for_edit_page(date)
     new_date = date.strftime("%m/%Y")
     return new_date
 end

  
  def short_period(pay_period)
    "#{pay_period.pay_start.to_s(:short)} - #{pay_period.pay_end.to_s(:short)}" if pay_period
  end
  def green_icon
     #if controller.action_name == action_name
          "fam-add"
    # else
          #"icon-plus"     
    #end
  end
  
  def detail_date(date)
    date.to_s(:detail) if date
  end
  
  def two_lines_or_200(text)
    match = /^.*\n.*\n/.match(text)
    if match
      match[0]
    else
      truncate(text, :length => 200)
    end
  end
 #Change date format in edit time
 def change_date_format_for_edit_page(date)
    new_date = date.strftime("%m/%y/%d")
    puts new_date.inspect
    return new_date
  end

 def statusreport(myid)
   #sr = current_user.organization.projects.find(myid)
   return myid.statusreports.find(:last).report_number
  end
  
  def statussent(name)
  n = name.statusreports.find(:last)
  return n.report_date.strftime("%b-%Y-%d") if !n.sent_by.blank?
  end
 def link_accounts
     @link_account = LinkAccount.new
 end
  def statussentdate(name)
  n = name.statusreports.find(:last)
  return n.sent_date.strftime("%b-%Y-%d %H:%M ") if !n.sent_by.blank?
  end

 #Change analysis at edit page 
 def change_analysis_for_edit_page(notes,analysis)
    if analysis.blank?
    analysis = notes 
    return analysis  
    end 
  end
def get_image_path(name)
         # return "#{Rails.root}/app/assets/images/#{name}"
         return "#{Rails.root}/public#{name}"
   
  end
def tabs
   @usertabs = current_user.orgtabs.collect{|tab| tab.tabname } if current_user
end


#for pdf report #
def pdfreportval(name)
n = name.project_reports.find(:last)
  return n.pdf_number if !n.pdf_number.blank?
end

# for user tabs 
def usermodtabs
 if current_user
curr = current_user.id  

@usertabs1 = SwitchTab.find_by_sql("select * from switch_tabs where user_value =#{curr} and state = 1")
@usertabs_modified = @usertabs1.collect{|tab| tab.module_name } 

 end
end 
# enf for user tabs 
   def web_presence(link)
      
      url = link 
      unless url.blank?
        url = "http://" << url unless url.match(/^https?:\/\//)
        #link_to(url,"#{url}",:target => "_blank")
	 return url
      end
  end

def  put_parenthesis(amount,type_of_account) 
amount = number_with_precision(amount, :precision => 2)
  if type_of_account
    value = type_of_account != "Invoice" ? "(#{amount})" : amount
    
  else
    amount = amount.to_s.strip
    value = (amount.to_s =~ /^-/)== 0 ?"(#{amount[1..-1]})" :amount
  end
end

 
end
