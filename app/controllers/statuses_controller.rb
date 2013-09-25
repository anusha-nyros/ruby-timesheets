class StatusesController < ApplicationController
  before_filter :authorize
  
  def index
    @statuses =  current_user.organization.statuses.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses }
    end
  end
  
  def new
    @status = Status.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status }
    end
  end

  
  def edit
    @status = current_user.organization.statuses.find(params[:id])
  end
 
  def create
    @status = Status.new(params[:status])
    @status.organization = current_user.organization
    respond_to do |format|
      if @status.save
        format.html { redirect_to statuses_url, notice: 'Status was successfully created.' }
        format.json { render json: @status, status: :created, location: @status }
      else
        format.html { render action: "new" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    @status = current_user.organization.statuses.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to statuses_url, notice: 'Status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @status = current_user.organization.statuses.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to statuses_url }
      format.json { head :no_content }
    end
  end
end