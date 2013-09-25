class CalendarsController < ApplicationController
  # GET /calendars
  # GET /calendars.json
  def index
  
#   if current_user.admin == true
#        @calendars = current_user.organization.calendars.find(:all, :conditions => "entry_date != 0" )
#        @date = params[:month] ? Date.parse(params[:month]) : Date.today
#      
#       if params[:FILTER] == "Team"
#        @calendars = current_user.organization.calendars.find(:all, :conditions => "entry_date != 0" )
#        @date = params[:month] ? Date.parse(params[:month]) : Date.today
#         
#        @chosen = "Team"
#       elsif params[:FILTER] == "My"
#       contact = User.find_by_id(current_user)
#       @calendars = contact.calendars.find(:all, :conditions => "entry_date != 0" )
#       @date = params[:month] ? Date.parse(params[:month]) : Date.today
#       @chosen = "My"
#   elsif params[:FILTER].blank?
      
       contact = User.find_by_id(current_user)
       @calendars = contact.calendars.find(:all, :conditions => "entry_date != 0" )
       @date = params[:month] ? Date.parse(params[:month]) : Date.today
       if @calendars.count == 0
       flash.now[:notice] = "You Have Not Any Activities. Please Schedule Your Activities."
       end
       
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calendars }
    end
  end
  
  def team_view
   @calendars = current_user.organization.calendars.find(:all, :conditions => ['entry_date != ? and  user_id != ?', 0, current_user.id])
   @date = params[:month] ? Date.parse(params[:month]) : Date.today
   if @calendars.count == 0
   flash.now[:notice] = "Your Team Members Not Yet Schedule Their Activities."
   end
  end


  # GET /calendars/1
  # GET /calendars/1.json
  def show
    @calendar = Calendar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @calendar }
    end
  end

  # GET /calendars/new
  # GET /calendars/new.json
  def new
    @calendar = Calendar.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @calendar }
    end
  end

  # GET /calendars/1/edit
  def edit
    @calendar = Calendar.find(params[:id])
  end

  # POST /calendars
  # POST /calendars.json
  def create
   
    @org_calendars= current_user.organization.calendars(:order=>'created_at ASC')
     puts @org_calendars.inspect
    @org_last_calendar=@org_calendars.find(:last)
    puts "#########################"
    puts @org_last_calendar.inspect
    puts "*****************************"
    if !@org_calendars.blank? && !@org_last_calendar.blank?
    y= @org_last_calendar.cal_num.gsub!("CAL-","")
   
    m=y.to_i
    m = m +1
    x = ("CAL-%0.4d" %m.to_i).to_s

    params[:calendar][:cal_num] = x
   
    @calendar = Calendar.new(params[:calendar])
    @calendar.organization = current_user.organization
    @calendar.user = current_user
    else 
    m = 1
    x = ("CAL-%0.4d" %m.to_i).to_s
    params[:calendar][:cal_num] = x
    @calendar = Calendar.new(params[:calendar])
    @calendar.organization = current_user.organization
    @calendar.user = current_user
    end
  
    @calendar.entry_date = change_date_format(params[:calendar][:entry_date]) if !(params[:calendar][:entry_date]).blank?
    respond_to do |format|
      if @calendar.save
        format.html { redirect_to calendars_url, notice: 'Calendar was successfully created.' }
        format.json { render json: @calendar, status: :created, location: @calendar }
      else
        format.html { render action: "new" }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calendars/1
  # PUT /calendars/1.json
  def update
    @calendar = Calendar.find(params[:id])
    params[:calendar][:entry_date] = change_date_format(params[:calendar][:entry_date]) if !(params[:calendar][:entry_date]).blank?
    respond_to do |format|
      if @calendar.update_attributes(params[:calendar])
        format.html { redirect_to calendars_url, notice: 'Calendar was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar = Calendar.find(params[:id])
    @calendar.destroy

    respond_to do |format|
      format.html { redirect_to calendars_url }
      format.json { head :no_content }
    end
  end
  
  def view
    @projects = current_user.organization.projects.find(:all, :conditions => "schedule_date != 0" )
   @date = params[:month] ? Date.parse(params[:month]) : Date.today 
  end
  
end
