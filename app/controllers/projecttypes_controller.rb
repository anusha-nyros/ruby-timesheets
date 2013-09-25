class ProjecttypesController < ApplicationController
before_filter :authorize
  # GET /projecttypes
  # GET /projecttypes.json
  def index
    @projecttypes = current_user.organization.projecttypes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projecttypes }
    end
  end

  # GET /projecttypes/1
  # GET /projecttypes/1.json
  def show
    @projecttype = Projecttype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @projecttype }
    end
  end

  # GET /projecttypes/new
  # GET /projecttypes/new.json
  def new
    @projecttype = Projecttype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @projecttype }
    end
  end

  # GET /projecttypes/1/edit
  def edit
    @projecttype = Projecttype.find(params[:id])
  end

  # POST /projecttypes
  # POST /projecttypes.json
  def create
    @projecttype = Projecttype.new(params[:projecttype])
    @projecttype.organization_id = current_user.organization_id
    respond_to do |format|
      if @projecttype.save
        format.html { redirect_to projecttypes_url, notice: 'Projecttype was successfully created.' }
        format.json { render json: @projecttype, status: :created, location: @projecttype }
      else
        format.html { render action: "new" }
        format.json { render json: @projecttype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projecttypes/1
  # PUT /projecttypes/1.json
  def update
    @projecttype = Projecttype.find(params[:id])

    respond_to do |format|
      if @projecttype.update_attributes(params[:projecttype])
        format.html { redirect_to projecttypes_url, notice: 'Projecttype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @projecttype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projecttypes/1
  # DELETE /projecttypes/1.json
  def destroy
    @projecttype = Projecttype.find(params[:id])
    @projecttype.destroy

    respond_to do |format|
      format.html { redirect_to projecttypes_url }
      format.json { head :no_content }
    end
  end
end
