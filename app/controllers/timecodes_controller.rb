class TimecodesController < ApplicationController
  before_filter :authorize
  
  def index
    @timecodes = current_user.organization.timecodes.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @timecodes }
    end
  end

 
 

  def new
    @timecode = Timecode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @timecode }
    end
  end

 
  def edit
    @timecode = current_user.organization.timecodes.find(params[:id])
  end

 
  def create
    @timecode = Timecode.new(params[:timecode])
    @timecode.organization = current_user.organization
    respond_to do |format|
      if @timecode.save
        format.html { redirect_to timecodes_url, notice: 'Timecode was successfully created.' }
        format.json { render json: @timecode, status: :created, location: @timecode }
      else
        format.html { render action: "new" }
        format.json { render json: @timecode.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    @timecode = current_user.organization.timecodes.find(params[:id])

    respond_to do |format|
      if @timecode.update_attributes(params[:timecode])
        format.html { redirect_to timecodes_url, notice: 'Timecode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @timecode.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @timecode = current_user.organization.timecodes.find(params[:id])
    @timecode.destroy

    respond_to do |format|
      format.html { redirect_to timecodes_url }
      format.json { head :no_content }
    end
  end
end