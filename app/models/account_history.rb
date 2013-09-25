#**************for account history of user************
class AccountHistory < ActiveRecord::Base
  attr_accessible :amount,:assign_to, :balance, :contact_id, :date, :description, :num_invoice, :organization_id, :reference, :statement_attachment, :type_of_account, :user_id
belongs_to :user
belongs_to :organization
belongs_to :contact
mount_uploader :statement_attachment, StatementAttachmentUploader
  validates_presence_of :assign_to

   def self.updating_balance_entry(amount,type_of_account,details,action,id,orgid)

    if details
	if action=='create'
	      previous_balance =  AccountHistory.select(:balance).where(:organization_id => orgid).last
	else
		if id.to_i!=1.to_i   
	      previous_balance =  AccountHistory.find_by_id(id.to_i-1)
	         
		else
		      previous_balance =  AccountHistory.find_by_id(id.to_i)
		      previous_balance.balance=0
		end#id.to_i!=1.to_i  
		
			if previous_balance.organization_id!=orgid.id  
				
		      while  previous_balance.organization_id!=orgid.id do
				if previous_balance.id==1
					previous_balance.balance=0
					break
		      	        end 
			      	      previous_balance =  AccountHistory.find_by_id(previous_balance.id-1)
			      	      
			end#while
			end #if

	end# details

      if previous_balance  

        balance = type_of_account == "Invoice" ?  previous_balance.balance.to_f + amount.to_f : previous_balance.balance.to_f - amount.to_f

      else
      
        balance = self.updating_balance_entry(amount,type_of_account,nil,'create',0,orgid)
     
      end
    else
      balance = type_of_account == "Invoice" ? 0.0 + amount.to_f : 0.0 - amount.to_f
    end
    
    if action=='update'
    	
    	update_records(id,balance,orgid)
    end


    return balance
    
  end# method

	def self.update_records(id,balance,orgid)
	
		last_id=AccountHistory.select(:id).last
		next_id= id.to_i+1
	
#		if id.to_i != last_id.id
			for sid in next_id .. last_id.id
				
				next_stmt=AccountHistory.find(sid) 
					if next_stmt.organization_id==orgid.id 
				 balance = next_stmt.type_of_account == "Invoice" ?  balance.to_f + next_stmt.amount.to_f : balance.to_f - next_stmt.amount.to_f
				next_stmt.balance=balance
				next_stmt.save
					end
			end
#		end
	end

end
