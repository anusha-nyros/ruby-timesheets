class SwitchController < ApplicationController
 def switches 
    curr= current_user.id 
     @orgtabs1 = current_user.orgtabs
     @tabs = Array.new
    @orgtabs = Array.new
    @orgtabs1.each do |id|
   @tabs << id.tabname
	end

@tabs.each do  |tab|
@orgtabs <<  SwitchTab.find_by_module_name_and_user_value(tab,current_user.id)
end 
 end 


def status
  @tab = SwitchTab.find(params[:id])	
   if @tab.state  == true 
  flash[:notice] = "#{@tab.module_name.capitalize} module is disabled  successfully"
  @tab.state = 0
  elsif @tab.state == false
    flash[:notice] = "#{@tab.module_name.capitalize} module is enabled successfully"
    @tab.state = 1         
  end
  if @tab.update_attributes(params[:switch_tab])      
      redirect_to "/switches"
   
    end

end
end
