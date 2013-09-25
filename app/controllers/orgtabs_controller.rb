class OrgtabsController < ApplicationController
  # GET /orgtabs
  # GET /orgtabs.json
  def index
    @orgtabs = Orgtab.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orgtabs }
    end
  end

  # GET /orgtabs/1
  # GET /orgtabs/1.json
  def show
    @orgtab = Orgtab.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @orgtab }
    end
  end

  # GET /orgtabs/new
  # GET /orgtabs/new.json
  def new
    @orgtab = Orgtab.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @orgtab }
    end
  end

  # GET /orgtabs/1/edit
  def edit
    @orgtab = Orgtab.find(params[:id])
  end

  # POST /orgtabs
  # POST /orgtabs.json
  def create
    @orgtab = Orgtab.new(params[:orgtab])

    respond_to do |format|
      if @orgtab.save
        format.html { redirect_to @orgtab, notice: 'Orgtab was successfully created.' }
        format.json { render json: @orgtab, status: :created, location: @orgtab }
      else
        format.html { render action: "new" }
        format.json { render json: @orgtab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orgtabs/1
  # PUT /orgtabs/1.json
  def update
    @orgtab = Orgtab.find(params[:id])

    respond_to do |format|
      if @orgtab.update_attributes(params[:orgtab])
        format.html { redirect_to @orgtab, notice: 'Orgtab was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @orgtab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orgtabs/1
  # DELETE /orgtabs/1.json
  def destroy
    @orgtab = Orgtab.find(params[:id])
    @orgtab.destroy

    respond_to do |format|
      format.html { redirect_to orgtabs_url }
      format.json { head :no_content }
    end
  end
end
