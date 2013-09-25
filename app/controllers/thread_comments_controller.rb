class ThreadCommentsController < ApplicationController
  before_filter :authorize
  # GET /thread_comments.json
  def index
    @thread_comments = ThreadComment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @thread_comments }
    end
  end

  # GET /thread_comments/1
  # GET /thread_comments/1.json
  def show
    
    @my_thread = MyThread.find(params[:id])
    @thread_comments = @my_thread.thread_comments
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @thread_comment }
    end
  end

  # GET /thread_comments/new
  # GET /thread_comments/new.json
  def new
    @thread_comment = ThreadComment.new
    @thread_comment.user = current_user
    @thread_comment.organization = current_user.organization
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @thread_comment }
    end
  end

  # GET /thread_comments/1/edit
  def edit
    @thread_comment = ThreadComment.find(params[:id])
  end

  # POST /thread_comments
  # POST /thread_comments.json
  def create
  
    
     @thread_comment = ThreadComment.new(params[:thread_comment])
     @thread_comment.user = current_user
     @thread_comment.organization = current_user.organization
     @thread_comment.my_thread = @my_thread = MyThread.find(params[:my_thread_id])
    respond_to do |format|
      if @thread_comment.save
        format.html { redirect_to @my_thread, notice: 'Comment was successfully created.' }
        format.json { render json: @my_thread, status: :created, location: @thread_comment }
      else
        format.html { redirect_to @my_thread, alert: 'Please Enter Comment.' }
      end
    end
  end

  # PUT /thread_comments/1
  # PUT /thread_comments/1.json
  def update
    @thread_comment = ThreadComment.find(params[:id])

    respond_to do |format|
      if @thread_comment.update_attributes(params[:thread_comment])
        format.html { redirect_to @thread_comment, notice: 'Thread comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @thread_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /thread_comments/1
  # DELETE /thread_comments/1.json
  def destroy
    @thread_comment = ThreadComment.find(params[:id])
    @thread_comment.destroy

    respond_to do |format|
      format.html { redirect_to thread_comments_url }
      format.json { head :no_content }
    end
  end
end
