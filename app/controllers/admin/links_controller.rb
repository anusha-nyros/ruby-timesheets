class Admin::LinksController < ApplicationController
 before_filter :authorize
  
  def index
   #render :text => params.inspect and return
   if params[:FILTER] == 'My'
       @q = current_user.links.search(params[:q])
       @links = @q.result(:distinct  => true).find(:all)
       @chosen = "My"
   elsif params[:FILTER] == 'Other'
    
    @q = current_user.organization.links.search(params[:q])
    @links = @q.result(:distinct  => true).find(:all, :conditions => ['share_option =? AND user_id !=?','Projects',current_user])
    
   #@q = Link.search(params[:q])
   #@g_link = @q.result(:distinct  => true).find(:all, :conditions => ['share_option =? AND user_id !=?','Global',current_user])
   #@g_link << @link 
   #@links = @g_link.flatten
    
    @chosen = "Other"
   
   elsif params[:FILTER].blank?
   
       @q = current_user.links.search(params[:q])
       @links = @q.result(:distinct  => true).find(:all)
      
       @chosen = "My"
   end
  
  end

  
  def show
    @link = Link.find(params[:id])
  end

  
  def new
    @link = Link.new
    
  end

  
  def edit
    @link = current_user.organization.links.find(params[:id])
  end

  
  def create
  
   
    @link = Link.new(params[:link])
    @link.user = current_user
    @link.organization = current_user.organization
    
    
    respond_to do |format|
      if @link.save
        format.html { redirect_to admin_links_url, notice: 'Link was successfully created.' }
        format.json { render json: @link, status: :created, location: @link }
      else
        format.html { render action: "new" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @link = current_user.organization.links.find(params[:id])


    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to admin_links_url, notice: 'Link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link = current_user.organization.links.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to admin_links_url }
      format.json { head :no_content }
    end
  end
  
  def search
    if params[:FILTER] == "My"
     @q = current_user.links.search(params[:q])
       @links = @q.result(:distinct  => true).find(:all)
       @chosen = "My"
    elsif params[:FILTER] == "Other"
      
      @q = current_user.organization.links.search(params[:q])
    @links = @q.result(:distinct  => true).find(:all, :conditions => ['share_option =? AND user_id !=?','Projects',current_user])
    
    #@q = Link.search(params[:q])
    #@g_link = @q.result(:distinct  => true).find(:all, :conditions => ['share_option =? AND user_id !=?','Global',current_user])
    #@g_link << @link
    
    #@links = @g_link.flatten
    
    @chosen = "Other"

  #  @q = current_user.organization.links.search(params[:q])
  #
  
    end
        
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end
  
  
  def image_view
    
   if params[:FILTER] == 'My'
       @q = current_user.links.search(params[:q])
       @links = @q.result(:distinct  => true).find(:all, :include => :linkimages, :conditions => ['linkimages.content_type =?','image/png'])
       @chosen = "My"
   elsif params[:FILTER] == 'Other'
    @q = current_user.organization.links.search(params[:q])
    @links = @q.result(:distinct  => true).find(:all, :include => :linkimages,
     :conditions => ['linkimages.content_type =? And share_option =? AND user_id !=?','image/png','Projects',current_user])
    #@q = Link.search(params[:q])
    #@g_link = @q.result(:distinct  => true).find(:all, :include => :linkimages,
    # :conditions => ['linkimages.content_type =? And share_option =? AND user_id !=?','image/png','Global',current_user])
    #@g_link << @link
    
    #@links = @g_link.flatten
    
    @chosen = "Other"
    
    
   elsif params[:FILTER].blank?
       @q = current_user.links.search(params[:q])
       @links = @q.result(:distinct  => true).find(:all, :include => :linkimages, :conditions => ['linkimages.content_type =?','image/png'])
       @chosen = "My"
   end
  
  end
  
  
  def sharebox	
  @link = current_user.links.find(params[:id])	
   if @link.sharebox == true 
  flash[:notice] = "Link is Unshared successfully"
  @link.sharebox = 0
  elsif @link.sharebox == false
    flash[:notice] = "Link is Shared successfully"
     @link.sharebox = 1         
  end
  if @link.update_attributes(params[:link])      
      redirect_to :action => :index,:page => params[:page]
    else
      flash[:notice] = "Unable to Share/Unshare Link" 
    end
end
  
  
end