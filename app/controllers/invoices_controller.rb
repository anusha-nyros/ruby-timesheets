class InvoicesController < ApplicationController
  # GET /invoices
  # GET /invoices.json
  def index
#    @invoices = current_user.organization.invoices
 @q = current_user.organization.invoices.search(params[:q])

if params[:FILTER] == "PAID"

#	@invoices = @q.result.where(:paid => 1).page(params[:page]).per(50)

	if params[:sel]
 		@invoices = @q.result.where(:paid => 1).page(params[:page]).per(params[:sel])
		@choosed = params[:sel]
	else
 		@invoices = @q.result.where(:paid => 1).page(params[:page]).per(25)
		@choosed = 25
	end    
	@chosen="PAID"
 
elsif params[:FILTER] == "UNPAID"

#	@invoices = @q.result.where(:paid => 0).page(params[:page]).per(50)

	if params[:sel]
 		@invoices = @q.result.where(:paid => 0).page(params[:page]).per(params[:sel])
		@choosed = params[:sel]
	else
 		@invoices = @q.result.where(:paid => 0).page(params[:page]).per(25)
		@choosed = 25
	end    
	@chosen="UNPAID"
else

	if params[:sel]
 		@invoices = @invoices = @q.result.page(params[:page]).per(params[:sel])
		@choosed = params[:sel]
		
	else
 		@invoices = @invoices = @q.result.page(params[:page]).per(25)
		@choosed = 25 
		
	end    

	#@invoices = @q.result.page(params[:page]).per(50)
	@chosen="ALL"	 
	
end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invoice }
    end 
  end

  # GET /invoices/new
  # GET /invoices/new.json
  def new
    @invoice = Invoice.new
    @invlineitem = @invoice.inv_line_items
        
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
  end  

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(params[:invoice])
    @invoice.date = change_date_format(params[:invoice][:date]) if !(params[:invoice][:date]).blank?
    @invoice.date = change_date_format(params[:invoice][:last_payment]) if !(params[:invoice][:last_payment]).blank?
    @invoice.organization=current_user.organization
    @invoice.user=current_user
    respond_to do |format| 
      if @invoice.save 
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render json: @invoice, status: :created, location: @invoice }
      else
        format.html { render action: "new" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1  <li class="<%= action_active('recap_by_group') %>">
  # PUT /invoices/1.json
  def update
    @invoice = Invoice.find(params[:id])
params[:invoice][:date]=change_date_format(params[:invoice][:date]) if !(params[:invoice][:date]).blank?
params[:invoice][:last_payment]=change_date_format(params[:invoice][:last_payment]) if !(params[:invoice][:last_payment]).blank?
    respond_to do |format|
      if @invoice.update_attributes(params[:invoice])
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :no_co}
    end
  end
  def search
  
         if params[:up]
          @secret = "up"
        end
        if params[:down]
          @secret = "down"
        end  

  	params[:q][:date] = change_date_format(params[:q][:date]) if !(params[:q][:date]).blank? 
  	params[:q][:last_payment] = change_date_format(params[:q][:last_payment]) if !(params[:q][:last_payment]).blank?
@q = current_user.organization.invoices.search(params[:q])
	    if !params[:mydata].blank? 
		   @invoices = @q.result.page(params[:page]).per(params[:mydata])
		   @choosed = params[:mydata]  
       elsif !params[:mydata]
		   @invoices = @q.result.page(params[:page]).per(25)
		   @choosed = 25

       end

#@q = current_user.organization.invoices.search(params[:q])
#@invoices = @q.result.page(params[:page]).per(5)

  end

  def ed
   @inv_line_item = InvLineItem.find(params[:id]) 
end

  def update_inv_line_item
    #@expense = current_user.organization.expenses.find(params[:id])
    @inv_line_item = InvLineItem.find(params[:id]) 
					
     #params[:payment][:date] = change_date_format(params[:payment][:date]) if !(params[:payment][:date]).blank? 
      if @inv_line_item.update_attributes(params[:inv_line_item])

	flash.notice = " Invoice Line Item Updated Successfully "
       redirect_to invoices_path
      else
        format.html { render action: "edit" }
        format.json { render json: @inv_line_item.errors, status: :unprocessable_entity }
      end
  end

  def del
   
    @inv_line_item = InvLineItem.find(params[:id])
	@inv_line_item.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :no_content }
    end
   end 

 def mailform
 
      @invid =  params[:ids]
      @invoiceid=params[:id2]
      puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
      puts @invid
      puts @invoiceid      
      puts "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"      

      render :partial => "mailform", :layout => false 
  
 end

def send_email
#      puts "2IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
#      puts params[:inv_id] 
#      puts params[:invoice_id]   
#      puts params[:mailid]
#      puts params[:msg]
#      puts "2IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"      

	@invoice=Invoice.find(params[:invoice_id])
	@line_item=InvLineItem.find(params[:inv_id])
	puts @line_item.inspect
 	pdf = InvoiceReportPdf.new(@invoice,@line_item, view_context)
 	pdf.render_file("#{Rails.root}/public/pdf_report_#{@line_item.id}.pdf")
        StatusMailer.email_pdf(params[:mailid],params[:msg],@line_item).deliver
#        flash[:notice] = "Email sent successfully"
#        redirect_to request.referer 
        render :partial => "success", :layout => false
 	system("rm #{Rails.root}/public/pdf_report_#{@line_item.id}.pdf")
	

end
  
def generate_invoice_as_pdf

	@invoice=Invoice.find(params[:invoice_id])
	@line_item=InvLineItem.find(params[:inv_id])
 	pdf = InvoiceReportPdf.new(@invoice,@line_item, view_context)
        send_data pdf.render, filename: "pdf_report_#{@line_item.id}.pdf",type: "application/pdf",           disposition: "inline"
		
end

end
