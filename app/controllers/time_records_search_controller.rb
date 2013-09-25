class TimeRecordsSearchController < ApplicationController
  before_filter :authorize
  skip_before_filter :verify_authenticity_token
  
 #Sending mails of issues report to the prescribed contacts
  def maillist
      @cntcts = current_user.organization.contacts
      @tmrec = Array.new
      params[:ids].split(",").map do |id|
       @tmrec << TimeRecord.find_by_id(id)
      end
     @tmrec_array =  params[:ids]
    render :partial => "maillist", :layout => false
   end

    def timerecords_mail
     mya= Array.new
     mycontacts=Array.new
     myemails = Array.new
  
     params[:time_record_check_all].split(",").map do |can_id|
                  if can_id == 'on' 
 		    next
	 	    end
     @contact = Contact.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
      #mycontacts.push(@contact.email)
      
       myemails.push(@contact.email)
     end
    
      

     #render :text => params[:project_format] and return 
     #params[:mailed_projects] = params[:mailed_projects].split(",").map { |s| puts s.to_i }
	       
          
            params[:mailed_projects].split(",").map do |can_id|
	                if can_id == 'on' 
 				          next
			            end   
                  
                  mya << TimeRecord.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
                  end
               @time_records = mya.flatten
                
      StatusMailer.time_record_email(myemails,mya,params[:msg]).deliver
            render :partial => "success", :layout => false
               
    end

  def all_time
  @cntcts = current_user.organization.contacts
  if current_user.admin == true
    @pay_periods = current_user.pay_periods.find(:all)
    time_records = []
    @pay_periods.each do |pay_period|
    @q = pay_period.time_records.search(params[:q])
    time_records << @q.result(:distinct  => true).find(:all)
    end
    
    time_records.flatten!


         if params[:sel]
               @time_records = Kaminari.paginate_array(time_records).page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
          else
               @time_records = Kaminari.paginate_array(time_records).page(params[:page]).per(50)
              @choosed = 50
          end 


   
    
 else
    @pay_periods = current_user.pay_periods.find(:all)
    time_records = []
    @pay_periods.each do |pay_period|
    @q = pay_period.time_records.where(:user_id  => current_user).search(params[:q])
    time_records << @q.result(:distinct  => true).find(:all)
    end
    
    time_records.flatten!

          if params[:sel]
               @time_records = Kaminari.paginate_array(time_records).page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
          else
               @time_records = Kaminari.paginate_array(time_records).page(params[:page]).per(50)
               @choosed = 50
          end 

 end

  end
  
  def search
     @cntcts = current_user.organization.contacts
     #change dateformat in search with activity date
    params[:q][:activity_date_cont] = change_date_format(params[:q][:activity_date_cont]) if !(params[:q][:activity_date_cont]).blank?
     params[:q][:activity_date_cont] =   params[:q][:activity_date_cont].to_date.strftime("%d/%Y/%m") if !  params[:q][:activity_date_cont].blank?


    
         if params[:up]
          @secret = "up"
         end
         if params[:down]
          @secret = "down"
         end   


    if current_user.admin == true
    @pay_periods = current_user.pay_periods.find(:all)
    time_records = []
    @pay_periods.each do |pay_period|
    @q = pay_period.time_records.search(params[:q])
    time_records << @q.result(:distinct  => true).find(:all)
    end
    
    time_records.flatten!

       if !params[:mydata].blank? 
        @time_records = Kaminari.paginate_array(time_records).page(params[:page]).per(params[:mydata])
        @choosed = params[:mydata]  
       elsif !params[:mydata]
        @time_records = Kaminari.paginate_array(time_records).page(params[:page]).per(50)
        @choosed = 50
       end
    
 else
    @pay_periods = current_user.pay_periods.find(:all)
    time_records = []
    @pay_periods.each do |pay_period|
    @q = pay_period.time_records.where(:user_id  => current_user).search(params[:q])
    time_records << @q.result(:distinct  => true).find(:all)
    end
    
    time_records.flatten!

        if !params[:mydata].blank? 
        @time_records = Kaminari.paginate_array(time_records).page(params[:page]).per(params[:mydata])
        @choosed = params[:mydata]  
        elsif !params[:mydata]
        @time_records = Kaminari.paginate_array(time_records).page(params[:page]).per(50)
        @choosed = 50
        end
 end
    
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end
end
