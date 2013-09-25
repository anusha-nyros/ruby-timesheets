class ContactsController < ApplicationController
  before_filter :authorize#, :check_account_type_project
  
  # GET /contacts
  # GET /contacts.json
  def index
    #@contacts = current_user.organization.contacts.all
   @q = current_user.organization.contacts.search(params[:q])
          if params[:sel]
              @contacts = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(params[:sel])
              @choosed = params[:sel]
          else
              @contacts = @q.result(:distinct  => true).order('updated_at DESC').page(params[:page]).per(10)
              @choosed = 10
          end  

     
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = current_user.organization.contacts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new
     @skills = current_user.organization.skills
    @groups = current_user.organization.groups
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = current_user.organization.contacts.find(params[:id])
    @skills = current_user.organization.skills
    @groups = current_user.organization.groups
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact])
    @contact.organization = current_user.organization
    @skills = current_user.organization.skills
    @groups = current_user.organization.groups
    checked_skills = check_skills_using(params[:skill_list])
    uncheck_missing_skills(@skills, checked_skills)
    checked_groups = check_groups_using(params[:group_list])
    uncheck_missing_groups(@groups, checked_groups)
    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = current_user.organization.contacts.find(params[:id])
    @skills = current_user.organization.skills
    @groups = current_user.organization.groups
    checked_skills = check_skills_using(params[:skill_list])
    uncheck_missing_skills(@skills, checked_skills)
    checked_groups = check_groups_using(params[:group_list])
    uncheck_missing_groups(@groups, checked_groups)
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = current_user.organization.contacts.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end
  
  
  def search
      
        if params[:up]
          @secret = "up"
        end
        if params[:down]
          @secret = "down"
        end  
    @q = current_user.organization.contacts.search(params[:q])

       if !params[:mydata].blank? 
       @contacts = @q.result(:distinct  => true).page(params[:page]).per(params[:mydata])
       @choosed = params[:mydata]  
       elsif !params[:mydata]
       @contacts = @q.result(:distinct  => true).page(params[:page]).per(10)
       @choosed = 10
       end


end
  
def show_clients
    #@contacts = current_user.organization.contacts.all
    #@q = current_user.organization.contacts.search(params[:q])
    @clients = current_user.organization.contacts.where(:contact_type => "Client")
end # Show_clients
  
def show_suppliers

    @q = current_user.organization.contacts.where(:contact_type => "Supplier").search(params[:q])
    @suppliers =@q.result.page(params[:page]).per(10)
    
end # Show_suppliers

  private
  
  def check_skills_using( skill_id_array )
    checked_skills = []
    checked_params = skill_id_array || []
    for check_box_id in checked_params
      skill = Skill.find(check_box_id)
      if not @contact.skills.include?(skill)
        @contact.skills << skill
      end
      checked_skills << skill
    end
    return checked_skills
  end
  
  def uncheck_missing_skills( skills, checked_skills)
    missing_skills = skills- checked_skills
    for skill in missing_skills
      if @contact.skills.include?(skill)
         @contact.skills.delete(skill)
       end
    end
  end
  #########
  def check_groups_using( group_id_array )
    checked_groups = []
    checked_params = group_id_array || []
    for check_box_id in checked_params
      group = Group.find(check_box_id)
      if not @contact.groups.include?(group)
        @contact.groups << group
      end
      checked_groups << group
    end
    return checked_groups
  end
  
  def uncheck_missing_groups( groups, checked_groups)
    missing_groups = groups- checked_groups
    for group in missing_groups
      if @contact.groups.include?(group)
         @contact.groups.delete(group)
       end
    end
  end
  
  
end
