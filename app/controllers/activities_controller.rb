class ActivitiesController < ApplicationController
  #layout 'app'  
  before_filter :authorize

  def index
    @q = current_user.organization.activities.search(params[:q])
    @activities = @q.result(:distinct  => true).page(params[:page])
      if params[:checked] == 'out'
       @q = current_user.organization.activities.search(params[:q])
       @activities = @q.result(:distinct  => true).find(:all, :conditions => {:doc_check => '1'})
      end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end
  
  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = current_user.organization.activities.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new
    if params[:category]
      @category = current_user.organization.categories.find(params[:category])
      @activity.category = @category
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = current_user.organization.activities.find(params[:id])
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(params[:activity])
    @activity.date = change_date_format(params[:activity][:date]) if !(params[:activity][:date]).blank?

    @activity.user = current_user
    @activity.organization = current_user.organization

    respond_to do |format|
      if @activity.save
        format.html { redirect_to activity_path(@activity), notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
   
    # make sure that user have access to activity else raise execption
    #current_user.user_activities.find(params[:id])
    params[:activity][:date] = change_date_format(params[:activity][:date]) if !(params[:activity][:date]).blank?
    # re query from database beacuse user_activities call have joins operation that make the record readony
    @activity = current_user.organization.activities.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to activity_path(@activity), notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy    
    @activity = current_user.organization.activities.find(params[:id])
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_path }
      format.json { head :no_content }
    end
  end
  
  def search
  params[:q][:date_gteq] = change_date_format(params[:q][:date_gteq]) if !(params[:q][:date_gteq]).blank?
    params[:q][:date_lteq] = change_date_format(params[:q][:date_lteq]) if !(params[:q][:date_lteq]).blank?    
    @q = current_user.organization.activities.search(params[:q])
    if params[:q]
      @activities = @q.result(:distinct  => true).page(params[:page]) if params[:q]
    end
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end
  
  def download
       
      @activity = current_user.organization.activities.find(params[:id])
      if @activity.doc_check == true
      Download.create(:activity_id => @activity.id, :user_id => current_user.id)
      
      send_file @activity.attachment.path
      elsif @activity.doc_check == false && current_user.id == @activity.user_id
      Download.create(:activity_id => @activity.id, :user_id => current_user.id)
      
      send_file @activity.attachment.path
      else
      
      flash[:notice] = "You can't download it until CheckedOut the Document"
      redirect_to :action => :show,:page => params[:page]	
      end
      #render :text => @activity.attachment.url and return
      
       
      
      #redirect_to :action => :show,:page => params[:page]
      
      #render :text => @activity.attachment.url and return
      #redirect_to :action => :index,:page => params[:page]
      #send_file(@upload.attach.path, :type => @upload.attach_content_type, :disposition => 'inline')
      #render :text => "downloaded" and return

  end
  
end