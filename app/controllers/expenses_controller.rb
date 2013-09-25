class ExpensesController < ApplicationController
  # GET /expenses
  # GET /expenses.json


 #Sending mails of issues report to the prescribed contacts
    def expense_mail
     mya= Array.new
     mycontacts=Array.new
     myemails = Array.new
  
     params[:expense_check_all].split(",").map do |can_id|
                  if can_id == 'on' 
 		    next
	 	    end
     @contact = Contact.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
      #mycontacts.push(@contact.email)
      
       myemails.push(@contact.email)
     end
    
     #render :text => params[:project_format] and return 
     params[:expense_list] =params[:expense_check].split(",").map { |s| puts s.to_i }
		
               params[:expense_check].split(",").map do |can_id|
	                if can_id == 'on' 
 				next
			     end   
                  
               mya << Expense.find(:first,:conditions => ["id LIKE ?",can_id.to_i] )
               end
               @expenses = mya.flatten
                
      StatusMailer.expense_email(myemails,mya).deliver
               flash[:notice] = "The mail sent successfully."
      redirect_to :action => 'index'
               
    end


  def index
  @cntcts = current_user.organization.contacts
  if current_user.admin == true
      if params[:expense] == 'approval'
        @q = current_user.organization.expenses.search(params[:q])
           if params[:sel]
            @expenses = @q.result(:distinct  => true).where(:status => '0').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]  
           else
            @expenses = @q.result(:distinct  => true).where(:status => '0').page(params[:page]).per(50)
            @choosed = 50
           end     
       
      else
        @q = current_user.organization.expenses.search(params[:q])
          if params[:sel]
            @expenses = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]  
           else
           @expenses = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
           end  
           # @expenses = @q.result(:distinct  => true).find(:all,:order => 'updated_at DESC')
            
      end  
     else
     
      if params[:expense] == 'approval'
      @q = current_user.organization.expenses.search(params[:q])

           if params[:sel]
            @expenses = @q.result(:distinct  => true).where(:status => '0').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]  
           else
            @expenses = @q.result(:distinct  => true).where(:status => '0').page(params[:page]).per(50)
            @choosed = 50
           end  
      else
       @q = current_user.expenses.search(params[:q])

           if params[:sel]
            @expenses = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:sel])
            @choosed = params[:sel]  
           else
           @expenses = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(50)
            @choosed = 50
           end 
      end
      end 


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    @expense = current_user.organization.expenses.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    @expense = Expense.new
    @payment = @expense.payments

     if current_user.admin == true
     @tasks = current_user.organization.projects.find(:all, :order => "title")
     elsif
     contact = Contact.find_by_user_id(current_user)
     @tasks = contact.projects.find(:all, :order => "title")
     else
     @tasks = []  #user doesnot have the contact type
     end

  
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = current_user.organization.expenses.find(params[:id])
    if current_user.admin == true
     @tasks = current_user.organization.projects.find(:all, :order => "title")
     elsif
     contact = Contact.find_by_user_id(current_user)
     @tasks = contact.projects.find(:all, :order => "title")
     else
     @tasks = []  #user doesnot have the contact type
     end

  
    
  end
  def pj
      
       @tasks = current_user.organization.projects.find(params[:id])
       respond_to do |format|
          #if @favorite.save
            format.json { render json: @tasks, status: :created }
          #else
            format.json { render json: @tasks.errors, status: :unprocessable_entity }
         # end
        end


  end


   def del
    @payment = Payment.find(params[:id])
    @payment.destroy
    update_amount(@payment.expense_id)
    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :no_content }
    end
   end


  # POST /expenses
  # POST /expenses.json
  def create
	
   if current_user.admin == true
     @tasks = current_user.organization.projects.find(:all, :order => "title")
     elsif
     contact = Contact.find_by_user_id(current_user)
     @tasks = contact.projects.find(:all, :order => "title")
     else
     @tasks = []  #user doesnot have the contact type
     end
  #render :text => "stop" and return
   @org_expenses = current_user.organization.expenses(:order=>'created_at ASC')
   @org_last_expense = @org_expenses.find(:last)
   if !@org_expenses.blank? && !@org_last_expense.blank?
    y= @org_last_expense.exp_number.gsub!("EXP-","") 
    m=y.to_i
    m = m +1
    x = ("EXP-%0.5d" %m.to_i).to_s
    params[:expense][:exp_number] = x
    @expense = Expense.new(params[:expense])
    @expense.organization = current_user.organization
   else 
    m = 1
    x = ("EXP-%0.5d" %m.to_i).to_s
    puts x
    params[:expense][:exp_number] = x
    @expense = Expense.new(params[:expense])
    @expense.organization = current_user.organization
   end
   
    #for changing the default date format
    @expense.date = change_date_format(params[:expense][:date]) if !(params[:expense][:date]).blank?
    @expense.approved_date = change_date_format(params[:expense][:approved_date]) if !(params[:expense][:approved_date]).blank?
    @expense.status = false
    @expense.user_id = current_user.id
    @expense.username = current_user.username
    
    respond_to do |format|
      if @expense.save
          @total_expense_amount = 0
         @total_approved_amt = 0#
         @tot_amt = []
         @tot_approved_amt = []#
         @total_amount = @expense.payments
         @total_amount.each do |k|
         @tot_amt << k.amount
         end 
          @total_app_amt = @expense.payments#
         @total_app_amt.each do |a|#
         @tot_approved_amt << a.approved_amt#
         end #
           @tot_amt.each do |t|
            @total_expense_amount = @total_expense_amount + t
         end 
         @tot_approved_amt.each do |t1|#
            @total_approved_amt = @total_approved_amt + t1#
         end #
         @total_paid_amt = 0##
         @tot_paid_amt = []##
         @total_paid_amount = @expense.payments##
         @total_paid_amount.each do |p|##
         @tot_paid_amt << p.pay_amount##
         end ##
        @tot_paid_amt.each do |t2|##
            @total_paid_amt = @total_paid_amt + t2##
         end ##
        @expense.update_attribute("paid_expense_amt",@total_paid_amt)##
        @expense.update_attribute("amount",@total_expense_amount)
        @expense.update_attribute("total_approved_amt",@total_approved_amt)#
         if current_user.admin?
        @expense.update_attributes(:status => 1,:approved_date => Date.today)
       end 
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render json: @expense, status: :created, location: @expense }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def status
	@expense_types = current_user.organization.expenses.find(:all, :order => "username")
  @expense = current_user.organization.expenses.find(params[:id])	
   if @expense.status == true 
  flash[:notice] = "Expense is Inactivated successfully"
   @expense.approved_date = nil
   @expense.status = 0
  elsif @expense.status == false
    flash[:notice] = "Expense is activated successfully"
      @expense.approved_date = Date.today
      @expense.status = 1         
  end
  if @expense.update_attributes(params[:expense])      
      redirect_to :action => :index,:page => params[:page]
    else
      flash[:notice] = "Unable to Active/Deactive Expense" 
    end
end




  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
    #render :text => "stop" and return
    @expense = current_user.organization.expenses.find(params[:id])
   params[:expense][:date] = change_date_format(params[:expense][:date]) if !(params[:expense][:date]).blank?

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
            @total_expense_amount = 0
         @total_approved_amt = 0#
         @tot_amt = []
         @tot_approved_amt = []#
         @total_amount = @expense.payments
         @total_amount.each do |k|
         @tot_amt << k.amount
         end 
          @total_app_amt = @expense.payments#
         @total_app_amt.each do |a|#
         @tot_approved_amt << a.approved_amt#
         end #
           @tot_amt.each do |t|
            @total_expense_amount = @total_expense_amount + t
         end 
         @tot_approved_amt.each do |t1|#
            @total_approved_amt = @total_approved_amt + t1#
         end #
         @total_paid_amt = 0##
         @tot_paid_amt = []##
         @total_paid_amount = @expense.payments##
         @total_paid_amount.each do |p|##
         @tot_paid_amt << p.pay_amount##
         end ##
        @tot_paid_amt.each do |t2|##
            @total_paid_amt = @total_paid_amt + t2##
         end ##
        @expense.update_attribute("paid_expense_amt",@total_paid_amt)##
        @expense.update_attribute("amount",@total_expense_amount)
        @expense.update_attribute("total_approved_amt",@total_approved_amt)#
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def ed
   @payment = Payment.find(params[:id]) 
  @pay = Payment.find(params[:id]) 
       # @payment.pay_amount = 0
      if current_user.admin == true
     @tasks = current_user.organization.projects.find(:all, :order => "title")
     elsif
     contact = Contact.find_by_user_id(current_user)
     @tasks = contact.projects.find(:all, :order => "title")
     else
     @tasks = []  #user doesnot have the contact type
     end
end 
  def update_payment
    #@expense = current_user.organization.expenses.find(params[:id])
    @payment = Payment.find(params[:id])
     
     #params[:payment][:date] = change_date_format(params[:payment][:date]) if !(params[:payment][:date]).blank?
      if @payment.update_attributes(params[:payment])
        update_amount(@payment.expense_id)
	flash.notice = "Payment Updated Successfully  "
       redirect_to expenses_path 
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
  end
     
  #search for expenses
  def search 
  @cntcts = current_user.organization.contacts
  params[:q][:date_cont] = change_date_format(params[:q][:date_cont]) if !(params[:q][:date_cont]).blank?
  params[:q][:date_cont] =  params[:q][:date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:date_cont]).blank?


   if current_user.admin == true
    @q = current_user.organization.expenses.search(params[:q])
      if !params[:mydata].blank? 
       @expenses = @q.result(:distinct => true).order("updated_at DESC").page(params[:page]).per(params[:mydata])
       @choosed = params[:mydata]  
       elsif !params[:mydata]
       @expenses = @q.result(:distinct => true).order("updated_at DESC").page(params[:page]).per(50)
       @choosed = 50
       end
    
    else
        contact = Contact.find_by_user_id(current_user)
        @q = contact.expenses.search(params[:q])
       if !params[:mydata].blank? 
       @expenses = @q.result(:distinct => true).order("updated_at DESC").page(params[:page]).per(params[:mydata])
       @choosed = params[:mydata]  
       elsif !params[:mydata]
       @expenses = @q.result(:distinct => true).order("updated_at DESC").page(params[:page]).per(50)
       @choosed = 50
       end
    end
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end

end


  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
     @expense = current_user.organization.expenses.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :no_content }
    end
  end


def analytics
 @expenses = current_user.organization.expenses.find(:all)
  @pays = []
@expenses.each do |exp|
exp.payments.each do |p|
@pays << p
end
end

@pays.flatten!

end 

private 

def update_amount(exp)
 @expense = current_user.organization.expenses.find(exp)
      @total_expense_amount = 0
         @total_approved_amt = 0#
         @tot_amt = []
         @tot_approved_amt = []#
         @total_amount = @expense.payments
         @total_amount.each do |k|
         @tot_amt << k.amount
         end 
          @total_app_amt = @expense.payments#
         @total_app_amt.each do |a|#
         @tot_approved_amt << a.approved_amt#
         end #
           @tot_amt.each do |t|
            @total_expense_amount = @total_expense_amount + t
         end 
         @tot_approved_amt.each do |t1|#
            @total_approved_amt = @total_approved_amt + t1#
         end #
          
        @total_paid_amt = 0##
         @tot_paid_amt = []##
         @total_paid_amount = @expense.payments##
         @total_paid_amount.each do |p|##
         @tot_paid_amt << p.pay_amount##
         end ##
        @tot_paid_amt.each do |t2|##
            @total_paid_amt = @total_paid_amt + t2##
         end ##
        @expense.update_attribute("paid_expense_amt",@total_paid_amt)##
        @expense.update_attribute("amount",@total_expense_amount)
        @expense.update_attribute("total_approved_amt",@total_approved_amt)#
        
end
end
