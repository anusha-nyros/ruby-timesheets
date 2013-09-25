class MeetingsController < ApplicationController
before_filter :authorize#, :check_account_type_project
  # GET /meetings
  # GET /meetings.json
  def index
    #@meetings = Meeting.all
    if current_user.admin == true
      @q = current_user.organization.meetings.search(params[:q])
      @meetings = @q.result(:distinct  => true).find(:all,:order => 'updated_at DESC')
      
      #from home stats
      if params[:upcomming] == 'meets'
      @q = current_user.organization.meetings.search(params[:q])
      @meetings = @q.result(:distinct  => true).find(:all, :conditions => ['meeting_date > ?',Date.today] )
      end 
      #home stats end

    else
     contact = Contact.find_by_user_id(current_user)
      if !contact.blank?
      @q = contact.meetings.search(params[:q])
       @meetings = @q.result(:distinct  => true).find(:all,:order => 'updated_at DESC')
      end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meetings }
    end
   end
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = current_user.organization.meetings.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/new
  # GET /meetings/new.json
  def new
    @meeting = Meeting.new
    #@attendees = current_user.organization.attendees
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/1/edit
  def edit
    @meeting = current_user.organization.meetings.find(params[:id])
    #@attendees = current_user.organization.attendees
  end

  # POST /meetings
  # POST /meetings.json
  def create
   # @meeting = Meeting.new(params[:meeting])
    @org_meetings= current_user.organization.meetings(:order=>'created_at ASC')
    @org_last_meeting=@org_meetings.find(:last)
    if !@org_meetings.blank? && !@org_last_meeting.blank?
    y= @org_last_meeting.meeting_number.gsub!("MEET-","")
    puts "###"
    m=y.to_i
    m = m +1
    x = ("MEET-%0.4d" %m.to_i).to_s
    puts x
    params[:meeting][:meeting_number] = x
    @meeting = Meeting.new(params[:meeting])
    @meeting.organization = current_user.organization
    #@attendees = current_user.organization.attendees
    #checked_attendees = check_attendees_using(params[:attendee_list])
    #uncheck_missing_attendees(@attendees, checked_attendees)
    else 
    m = 1
    x = ("MEET-%0.4d" %m.to_i).to_s
    puts x
    params[:meeting][:meeting_number] = x
    @meeting = Meeting.new(params[:meeting])
    @meeting.organization = current_user.organization
    #@attendees = current_user.organization.attendees
    #checked_attendees = check_attendees_using(params[:attendee_list])
    #uncheck_missing_attendees(@attendees, checked_attendees)
    end

    #for changing the default date format
    @meeting.meeting_date = change_date_format(params[:meeting][:meeting_date]) if !(params[:meeting][:meeting_date]).blank?

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to meetings_url, notice: 'Meeting was successfully created.' }
        format.json { render json: @meeting, status: :created, location: @meeting }
      else
        format.html { render action: "new" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meetings/1
  # PUT /meetings/1.json
  def update
    @meeting = current_user.organization.meetings.find(params[:id])
#for update time change date format params
    params[:meeting][:meeting_date] = change_date_format(params[:meeting][:meeting_date]) if !(params[:meeting][:meeting_date]).blank?
    #@attendees = current_user.organization.attendees
    #checked_attendees = check_attendees_using(params[:attendee_list])
    #uncheck_missing_attendees(@attendees, checked_attendees)
    respond_to do |format|
      if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to meetings_url, notice: 'Meeting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting = current_user.organization.meetings.find(params[:id])
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to meetings_url }
      format.json { head :no_content }
    end
  end
# for searching

  def search
    #change dateformat when search
    params[:q][:meeting_date_cont] = change_date_format(params[:q][:meeting_date_cont]) if !(params[:q][:meeting_date_cont]).blank?
   if current_user.admin == true
    @q = current_user.organization.meetings.search(params[:q])
    if params[:q]
  
      @meetings = @q.result(:distinct  => true)#.find(:all,:order=>"updated_at DESC")
    
    end
    else
    contact = Contact.find_by_user_id(current_user)
       @q = contact.meetings.search(params[:q])
      if params[:q]
      @meetings = @q.result(:distinct  => true)
      
    end
    end
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end

 private
  
  def check_attendees_using( attendee_id_array )
    checked_attendees = []
    checked_params = attendee_id_array || []
    for check_box_id in checked_params
      attendee = Attendee.find(check_box_id)
      if not @meeting.attendees.include?(attendee)
        @meeting.attendees << attendee
      end
      checked_attendees << attendee
    end
    return checked_attendees
  end
  
  def uncheck_missing_attendees( attendees, checked_attendees)
    missing_attendees = attendees- checked_attendees
    for attendee in missing_attendees
      if @meeting.attendees.include?(attendee)
         @meeting.attendees.delete(attendee)
       end
    end
  end
  
end
