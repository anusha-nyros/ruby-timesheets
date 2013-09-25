class Admin::PayPeriodsController < Admin::AdminController

  before_filter :update_timesheet_number, :only=>'index'
  # GET /pay_periods
  # GET /pay_periods.json
  def index
    @pay_periods = current_user.pay_periods.order('pay_start desc').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pay_periods }
    end
  end

  # GET /pay_periods/1
  # GET /pay_periods/1.json
  # def show
  #   @pay_period = PayPeriod.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @pay_period }
  #   end
  # end

  # GET /pay_periods/new
  # GET /pay_periods/new.json
  def new
    @pay_period = PayPeriod.new
    @projects = current_user.organization.projects.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pay_period }
    end
  end

  # GET /pay_periods/1/edit
  def edit
    @pay_period = current_user.pay_periods.find(params[:id])
    @projects = current_user.organization.projects.all
  end

  # POST /pay_periods
  # POST /pay_periods.json
  def create
  
    @org_pay_periods= current_user.organization.pay_periods(:order=>'created_at ASC')
    @org_last_period=@org_pay_periods.find(:last)
    if !@org_pay_periods.blank? && !@org_last_period.blank?
    y= @org_last_period.timesheet_number.gsub!("TIME-","")
    puts "###"
    m=y.to_i
    m = m +1
    x = ("TIME-%0.4d" %m.to_i).to_s
    puts x
    params[:pay_period][:timesheet_number] = x
    @pay_period = PayPeriod.new(params[:pay_period])
    @pay_period.organization = current_user.organization
   
    else 
    m = 1
    x = ("TIME-%0.4d" %m.to_i).to_s
    puts x
    params[:pay_period][:timesheet_number] = x
    @pay_period = PayPeriod.new(params[:pay_period])
    @pay_period.organization = current_user.organization
   
    end
    
   #change default date format
    @pay_period.pay_start = change_date_format(params[:pay_period][:pay_start]) if !(params[:pay_period][:pay_start]).blank?
    @pay_period.pay_end = change_date_format(params[:pay_period][:pay_end]) if !(params[:pay_period][:pay_end]).blank?
    @pay_period.pay_day = change_date_format(params[:pay_period][:pay_day]) if !(params[:pay_period][:pay_day]).blank?
    respond_to do |format|
      if @pay_period.save
        format.html { redirect_to admin_pay_periods_path, notice: 'Pay period was successfully created.' }
        format.json { render json: @pay_period, status: :created, location: @pay_period }
      else
        format.html { render action: "new" }
        format.json { render json: @pay_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pay_periods/1
  # PUT /pay_periods/1.json
  def update
    @pay_period = current_user.pay_periods.find(params[:id])
 #change default date format when update time also 
  params[:pay_period][:pay_start] = change_date_format(params[:pay_period][:pay_start]) if !(params[:pay_period][:pay_start]).blank?
  params[:pay_period][:pay_end] = change_date_format(params[:pay_period][:pay_end]) if !(params[:pay_period][:pay_end]).blank?
  params[:pay_period][:pay_day] = change_date_format(params[:pay_period][:pay_day]) if !(params[:pay_period][:pay_day]).blank?
    respond_to do |format|
      if @pay_period.update_attributes(params[:pay_period])
        format.html { redirect_to admin_pay_periods_path, notice: 'Pay period was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pay_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pay_periods/1
  # DELETE /pay_periods/1.json
  def destroy
    @pay_period = current_user.pay_periods.find(params[:id])
    @pay_period.destroy

    respond_to do |format|
      format.html { redirect_to admin_pay_periods_url, notice: "Successfully delete period" }
      format.json { head :no_content }
    end
  end
end