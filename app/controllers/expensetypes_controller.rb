class ExpensetypesController < ApplicationController
  before_filter :authorize
  # GET /expensetypes
  # GET /expensetypes.json
  def index
    @expensetypes = current_user.organization.expensetypes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expensetypes }
    end
  end

  # GET /expensetypes/1
  # GET /expensetypes/1.json
  def show
    @expensetype = Expensetype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expensetype }
    end
  end

  # GET /expensetypes/new
  # GET /expensetypes/new.json
  def new
    @expensetype = Expensetype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expensetype }
    end
  end

  # GET /expensetypes/1/edit
  def edit
    @expensetype = Expensetype.find(params[:id])
  end

  # POST /expensetypes
  # POST /expensetypes.json
  def create
    @expensetype = Expensetype.new(params[:expensetype])
    @expensetype.organization_id = current_user.organization_id
    respond_to do |format|
      if @expensetype.save
        format.html { redirect_to expensetypes_url, notice: 'Expensetype was successfully created.' }
        format.json { render json: @expensetype, status: :created, location: @expensetype }
      else
        format.html { render action: "new" }
        format.json { render json: @expensetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expensetypes/1
  # PUT /expensetypes/1.json
  def update
    @expensetype = Expensetype.find(params[:id])

    respond_to do |format|
      if @expensetype.update_attributes(params[:expensetype])
        format.html { redirect_to expensetypes_url, notice: 'Expensetype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @expensetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expensetypes/1
  # DELETE /expensetypes/1.json
  def destroy
    @expensetype = Expensetype.find(params[:id])
    @expensetype.destroy

    respond_to do |format|
      format.html { redirect_to expensetypes_url }
      format.json { head :no_content }
    end
  end
end
