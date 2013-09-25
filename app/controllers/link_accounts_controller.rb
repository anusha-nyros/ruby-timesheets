class LinkAccountsController < ApplicationController
	 skip_before_filter  :verify_authenticity_token
  # GET /link_accounts
  # GET /link_accounts.json
  def index
    @link_accounts = LinkAccount.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @link_accounts }
    end
  end

  # GET /link_accounts/1
  # GET /link_accounts/1.json
  def show
    @link_account = LinkAccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link_account }
    end
  end

  # GET /link_accounts/new
  # GET /link_accounts/new.json
  def new
    @link_account = LinkAccount.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link_account }
    end
  end

  # GET /link_accounts/1/edit
  def edit
    @link_account = LinkAccount.find(params[:id])
  end

  # POST /link_accounts
  # POST /link_accounts.json
  def create
    #@link_account = LinkAccount.new(params[:link_account])
    check= "false"
    @link_accounts= LinkAccount.all
    begin 
    targetid = User.select("id").where(:username => params[:link_account][:target])
    @link_accounts.each do |link_account|
        if link_account.source_id == params[:link_account][:source_id].to_i && link_account.target_id == targetid[0].id && link_account.ignor == true
             link_account.ignor = false 
             link_account.accept =  "1"
             link_account.save 
           check = "true"
          flash[:notice] = "Account has been re-enabled"
          break
        elsif link_account.source_id == params[:link_account][:source_id].to_i && link_account.target_id == targetid[0].id 
           check = "true"
          flash[:notice] = "Your request has been approved"
           break
        end
      end
    rescue
     flash[:error] = "username doesn't match"
     redirect_to root_path
    else   
	begin    
    if check == "false"
      @target = User.find(targetid) 
      @link_account = LinkAccount.new(params[:link_account])
      @link_account.target_id = @target.id
      @link_account.target_admin_id = @target.organization_id
      @link_account.request = true     
        if @link_account.save
          flash[:notice] = "Request has been sent successfully"
          redirect_to root_path
        else
          #format.html { render action: "new"}
          #format.json { render json: @link_account.errors, status: :unprocessable_entity }
        end
      else
      redirect_to root_path
    end
     rescue
     flash[:error] = "username doesn't match"
     redirect_to root_path
     end
   end
  end

  # PUT /link_accounts/1
  # PUT /link_accounts/1.json
  def update
    @link_account = LinkAccount.find(params[:id])

    respond_to do |format|
      if @link_account.update_attributes(params[:link_account])
        format.html { redirect_to @link_account, notice: 'Link account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @link_account.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def accept_request
    @link_account = LinkAccount.find(:all ,:conditions => ["target_id=? and source_id=?",params[:target], params[:source]])
   if @link_account[0].update_attribute("accept",true) && @link_account[0].update_attribute("request",false) && @link_account[0].update_attribute("remove",false)
        format.html { redirect_to @link_account[0], notice: 'Link account was successfully created.' }
        format.json { render json: @link_account[0], status: :created, location: @link_account }
    else
        puts "Error While Updating LinkAccount accept through Ajax "   
    end
  end
  
  def unlink
    @link_account = LinkAccount.find(params[:id])
   if @link_account.update_attribute("accept",false) && @link_account.update_attribute("request",false) && @link_account.update_attribute("ignor",true)
        render :nothing => true
    else
        puts "Error While Updating LinkAccount unlink through Ajax "   
    end
  end

  # DELETE /link_accounts/1
  # DELETE /link_accounts/1.json
  def destroy
    @link_account = LinkAccount.find(params[:id])
    @link_account.destroy

    respond_to do |format|
      format.html { redirect_to link_accounts_url }
      format.json { head :no_content }
    end
  end
end