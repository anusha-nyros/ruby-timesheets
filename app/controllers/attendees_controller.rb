class AttendeesController < ApplicationController

before_filter :authorize
  def index
    @attendees = current_user.organization.attendees.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attendees }
    end
  end

  

 
  def new
    @attendee = Attendee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attendee }
    end
  end

 
  def edit
    @attendee = current_user.organization.attendees.find(params[:id])
  end

 
  def create
    @attendee = Attendee.new(params[:attendee])
    @attendee.organization = current_user.organization
    respond_to do |format|
      if @attendee.save
        format.html { redirect_to attendees_url, notice: 'Attendee was successfully created.' }
        format.json { render json: @attendee, status: :created, location: @attendee }
      else
        format.html { render action: "new" }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def update
    @attendee = current_user.organization.attendees.find(params[:id])

    respond_to do |format|
      if @attendee.update_attributes(params[:attendee])
        format.html { redirect_to attendees_url, notice: 'Attendee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def destroy
    @attendee = current_user.organization.attendees.find(params[:id])
    @attendee.destroy

    respond_to do |format|
      format.html { redirect_to attendees_url }
      format.json { head :no_content }
    end
  end
end
