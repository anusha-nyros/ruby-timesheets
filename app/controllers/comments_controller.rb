class CommentsController < ApplicationController
before_filter :authorize, :check_account_type_project
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
#    if current_user.admin==true
#    #@projects = current_user.organization.projects.find(:all, :conditions => {:active => 1 })
#    @projects = current_user.organization.projects.find_by_sql('select * from projects where notes!="";and active=1;')
#    else
#    contact = Contact.find_by_user_id(current_user)
#    #@projects = contact.projects.find(:all)
#    @projects = contact.projects.find_by_sql('select * from projects where notes!="" and active=1;')
#   end
    if current_user.admin == true
    #@projects = current_user.organization.projects.find(:all, :conditions =>[ "active=? and notes !=?",1,'' ])
     @projects = current_user.organization.projects.find(:all, :include => :comments, :conditions =>[ "active=? and notes !=?",1,'' ], :order => 'comments.created_at DESC' )
    
    else
      contact = Contact.find_by_user_id(current_user)
      if !contact.blank?
    #@projects = contact.projects.find(:all, :conditions =>[ "active=? and notes !=?",1,'' ])
      @projects = contact.projects.find(:all, :include => :comments, :conditions =>[ "active=? and notes !=?",1,'' ], :order => 'comments.created_at DESC' )
    end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])
    #@project = Project.find(params[:id])
    #@project = @comment.project
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    
    @comment = Comment.new
    @project = Project.find(params[:project_id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @project = @comment.project
    #@project = Project.find(params[:project_id])#3333333333333

  end

  # POST /comments
  # POST /comments.json
  def create
      # render :text => params.inspect and return
       @comment = Comment.new(params[:comment])
       @comment.project = @project = Project.find(params[:comment][:project_id])
       
    respond_to do |format|
      if @comment.save
        flash[:notice] = "Your Comment was successfully created."
        #format.html { redirect_to :action => "new", :project_id => @project.id, notice: 'Your Comment was successfully created.' }
        format.html { redirect_to :action => "new", :project_id => @project.id }
        #format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        #format.html { redirect_to request.referer, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        #format.html { redirect_to request.referer, alert: "Comment should not be blank." }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
     @comment.project = @project = Project.find(params[:comment][:project_id]) #3333333333333
    respond_to do |format|

      if @comment.update_attributes(params[:comment])
         flash[:notice] = "Your Comment was successfully Updated."
         #format.html { redirect_to @project }
        #format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.html { redirect_to :action => "new", :project_id => @project.id }
        format.json { head :no_content }
        
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      #format.html { redirect_to comments_url}
      format.html { redirect_to request.referer}
      format.json { head :no_content }
    end
  end
end
