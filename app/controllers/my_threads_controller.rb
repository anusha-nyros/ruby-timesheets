class MyThreadsController < ApplicationController
  
  before_filter :authorize
  # GET /my_threads
  # GET /my_threads.json
  def index
    

    @q = current_user.organization.my_threads.search(params[:q])
    if params[:sel]
    	@my_threads = @q.result(:distinct  => true).includes(:thread_comments).order('thread_comments.updated_at DESC').page(params[:page]).per(params[:sel])   
    	@chosen = params[:sel]   
     else
    	@my_threads = @q.result(:distinct => true).includes(:thread_comments).order('thread_comments.updated_at DESC').page(params[:page]).per(50)   
	@chosen = 50
    end     


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @my_threads }
    end
  end

  # GET /my_threads/1
  # GET /my_threads/1.json
  def show
    @my_thread = current_user.organization.my_threads.find(params[:id])
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @my_thread }
    end
  end

  # GET /my_threads/new
  # GET /my_threads/new.json
  def new
    @my_thread = MyThread.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @my_thread }
    end
  end

  # GET /my_threads/1/edit
  def edit
    @my_thread = current_user.organization.my_threads.find(params[:id])
  end

  # POST /my_threads
  # POST /my_threads.json
  def create
  
    @org_threads= current_user.organization.my_threads(:order=>'created_at ASC')
    @org_last_thread=@org_threads.find(:last)
    if !@org_threads.blank? && !@org_last_thread.blank? #getting system generated field value
    y= @org_last_thread.thread_number.gsub!("THR-","")
    m=y.to_i
    m = m +1
    x = ("THR-%0.5d" %m.to_i).to_s
    params[:my_thread][:thread_number] = x
    @my_thread = MyThread.new(params[:my_thread])
    @my_thread.organization = current_user.organization
    @my_thread.user = current_user
    else 
    m = 1
    x = ("THR-%0.5d" %m.to_i).to_s # system generated field value
   
    params[:my_thread][:thread_number] = x
    @my_thread = MyThread.new(params[:my_thread])
    @my_thread.organization = current_user.organization
    @my_thread.user = current_user
    end
  
    respond_to do |format|
      if @my_thread.save
        format.html { redirect_to my_threads_url, notice: 'Thread was successfully created.' }
        format.json { render json: @my_thread, status: :created, location: @my_thread }
      else
        format.html { render action: "new" }
        format.json { render json: @my_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /my_threads/1
  # PUT /my_threads/1.json
  def update
    @my_thread = current_user.organization.my_threads.find(params[:id])

    respond_to do |format|
      if @my_thread.update_attributes(params[:my_thread])
        format.html { redirect_to my_threads_url, notice: 'Thread was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @my_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my_threads/1
  # DELETE /my_threads/1.json
  def destroy
    @my_thread = current_user.organization.my_threads.find(params[:id])
    @my_thread.destroy

    respond_to do |format|
      format.html { redirect_to my_threads_url }
      format.json { head :no_content }
    end
  end
  
   
  def search #for search
  
  params[:q][:creation_date_cont] = change_date_format(params[:q][:creation_date_cont]) if !(params[:q][:creation_date_cont]).blank?
  params[:q][:creation_date_cont] = params[:q][:creation_date_cont].to_date.strftime("%d/%Y/%m") if !(params[:q][:creation_date_cont]).blank?
        
        if params[:up]
          @secret = "up"
        end
        if params[:down]
          @secret = "down"
        end   
       @q = current_user.organization.my_threads.search(params[:q]) 
       if !params[:mydata].blank? 
       @my_threads = @q.result(:distinct  => true).page(params[:page]).per(params[:mydata])
       #@my_threads = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(2)
       @chosen = params[:mydata]  
       elsif !params[:mydata]
       @my_threads = @q.result(:distinct  => true).page(params[:page]).per(50) 
	@chosen = 50     
       end
    respond_to do |format|
      format.html
      format.json { render json: @my_thread }
    end
  end
end
