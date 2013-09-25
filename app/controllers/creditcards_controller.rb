class CreditcardsController < ApplicationController
 before_filter :authorize
 layout "credit"
  # GET /creditcards
  # GET /creditcards.json
  def index
    @creditcards = Creditcard.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @creditcards }
    end
  end

  # GET /creditcards/1
  # GET /creditcards/1.json
  def show
    @creditcard = Creditcard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @creditcard }
    end
  end

  # GET /creditcards/new
  # GET /creditcards/new.json
  def new
    @creditcard = Creditcard.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @creditcard }
    end
  end

  # GET /creditcards/1/edit
  def edit
    @creditcard = Creditcard.find(params[:id])
  end

  # POST /creditcards
  # POST /creditcards.json
  def create
    
    params[:creditcard][:expiryon] = change_creditcard_date(params[:creditcard][:expiryon]) if !params[:creditcard][:expiryon].blank?   
    @creditcard = Creditcard.new(params[:creditcard])
    @creditcard.user = current_user
    @creditcard.organization = current_user.organization 
    respond_to do |format|
      if @creditcard.save
        current_user.organization.credit_status = true
        current_user.organization.save
        current_user.credit_status = true 
        current_user.save
        format.html { redirect_to @creditcard, notice: 'Transaction was successfully completed.' }
        format.json { render json: @creditcard, status: :created, location: @creditcard }
      else
        format.html { render action: "new" }
        format.json { render json: @creditcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /creditcards/1
  # PUT /creditcards/1.json
  def update
    @creditcard = Creditcard.find(params[:id])
     params[:creditcard][:expiryon] = change_creditcard_date(params[:creditcard][:expiryon])   
    respond_to do |format|
      if @creditcard.update_attributes(params[:creditcard])
        format.html { redirect_to @creditcard, notice: 'Creditcard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @creditcard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /creditcards/1
  # DELETE /creditcards/1.json
  def destroy
    @creditcard = Creditcard.find(params[:id])
    @creditcard.destroy

    respond_to do |format|
      format.html { redirect_to creditcards_url }
      format.json { head :no_content }
    end
  end
end