class TasktypesController < ApplicationController
  # GET /tasktypes
  # GET /tasktypes.json
  def index
    @tasktypes = current_user.organization.tasktypes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasktypes }
    end
  end

  # GET /tasktypes/1
  # GET /tasktypes/1.json
  def show
    @tasktype = Tasktype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tasktype }
    end
  end

  # GET /tasktypes/new
  # GET /tasktypes/new.json
  def new
    @tasktype = Tasktype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tasktype }
    end
  end

  # GET /tasktypes/1/edit
  def edit
    @tasktype = Tasktype.find(params[:id])
  end

  # POST /tasktypes
  # POST /tasktypes.json
  def create
    @tasktype = Tasktype.new(params[:tasktype])
    @tasktype.organization_id = current_user.organization_id
    respond_to do |format|
      if @tasktype.save
        format.html { redirect_to @tasktype, notice: 'Tasktype was successfully created.' }
        format.json { render json: @tasktype, status: :created, location: @tasktype }
      else
        format.html { render action: "new" }
        format.json { render json: @tasktype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasktypes/1
  # PUT /tasktypes/1.json
  def update
    @tasktype = Tasktype.find(params[:id])
    @tasktype.organization_id = current_user.organization_id

    respond_to do |format|
      if @tasktype.update_attributes(params[:tasktype])
        format.html { redirect_to tasktypes_url, notice: 'Tasktype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tasktype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasktypes/1
  # DELETE /tasktypes/1.json
  def destroy
    @tasktype = Tasktype.find(params[:id])
    @tasktype.destroy

    respond_to do |format|
      format.html { redirect_to tasktypes_url }
      format.json { head :no_content }
    end
  end
end
