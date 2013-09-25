class StatisticsController < ApplicationController
  def statistics
    @projects = current_user.organization.projects
     if current_user.admin == true
      @q = current_user.organization.project_types.search(params[:q])
      else
      contact = Contact.find_by_user_id(current_user)
      @q = contact.project_types.search(params[:q])
    end
  end
  
  def search
    
@project_types = current_user.organization.projects.find(:all, :order => "project_name" ,:select=> 'DISTINCT project_name')

    params[:q][:date_created_gteq] = change_date_format(params[:q][:date_created_gteq]) if !(params[:q][:date_created_gteq]).blank?
    params[:q][:date_created_lteq] = change_date_format(params[:q][:date_created_lteq]) if !(params[:q][:date_created_lteq]).blank?

   if current_user.admin == true
    @q = current_user.organization.project_types.search(params[:q])
    if params[:q]
      @projects = @q.result(:distinct  => true)  
    end
    else
    contact = Contact.find_by_user_id(current_user)
       @q = contact.project_types.search(params[:q])
      if params[:q]
      @projects = @q.result(:distinct  => true) 
    end
    end
    
    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end



  
end
