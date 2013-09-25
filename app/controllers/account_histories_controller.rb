class AccountHistoriesController < ApplicationController
  # GET /account_histories
  # GET /account_histories.json
  def index
#    @account_histories = AccountHistory.all
if current_user.admin?
	@account_histories = current_user.organization.account_histories
	    puts "CCCCCCCCCCCCCCCCCCCCCC"
    puts @account_histories.class
    puts "CCCCCCCCCCCCCCCCCCCCCC"

else
	c=Contact.select(:contact).where(:user_id =>current_user.id, :organization_id=>current_user.organization)
	@account_histories = current_user.organization.account_histories.where(:assign_to =>c[0].contact )

end
#@account_histories = AccountHistory.where(:assign_to => current_user.username)
#puts current_user.organization.name

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @account_histories }
    end
  end

def balance_summary

@accounts = current_user.organization.account_histories
@suppliers=Contact.select([:contact , :company]).where(:contact_type => "supplier", :organization_id=>current_user.organization)

end

  # GET /account_histories/1
  # GET /account_histories/1.json
  def show
    @account_history = AccountHistory.find(params[:id])
 
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account_history }
    end
  end

  # GET /account_histories/new
  # GET /account_histories/new.json
  def new
    @account_history = AccountHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account_history }
    end
  end

  # GET /account_histories/1/edit
  def edit
    @account_history = AccountHistory.find(params[:id])
  end

  # POST /account_histories
  # POST /account_histories.json
  
  def create
    params[:account_history][:date] = change_date_format(params[:account_history][:date]) if !(params[:account_history][:date]).blank?
    @account_history = AccountHistory.new(params[:account_history])
    @account_history.user=current_user
    @account_history.organization=current_user.organization

@account_history.balance = AccountHistory.updating_balance_entry(params[:account_history][:amount],params[:account_history][:type_of_account],1,'create',0,current_user.organization)
    puts @account_history.balance
    respond_to do |format| 
      if @account_history.save 
        format.html { redirect_to account_histories_path, notice: 'Account history was successfully created.' } 
        format.json { render json: account_histories_path, status: :created, location: @account_histories }
      else 
        format.html { render action: "new" }
        format.json { render json: @account_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /account_histories/1
  # PUT /account_histories/1.json
  def update
    params[:account_history][:date] = change_date_format(params[:account_history][:date]) if !(params[:account_history][:date]).blank?

    @account_history = AccountHistory.find(params[:id])
@account_history.balance = AccountHistory.updating_balance_entry(params[:account_history][:amount],params[:account_history][:type_of_account],1,'update',params[:id],current_user.organization) 

    respond_to do |format|
      if @account_history.update_attributes(params[:account_history])
        format.html { redirect_to account_histories_path, notice: 'Account history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @account_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_histories/1
  # DELETE /account_histories/1.json
  def destroy
    @account_history = AccountHistory.find(params[:id])
    @account_history.destroy

    respond_to do |format|
      format.html { redirect_to account_histories_url }
      format.json { head :no_content }
    end
  end
end
