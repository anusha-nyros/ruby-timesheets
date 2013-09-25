class Invoice < ActiveRecord::Base
  attr_accessible :aging, :amount, :balance, :client, :date, :days_old, :invoice, :last_payment, :organization_id, :paid, :reference, :user_id
belongs_to :organization
belongs_to :user 
has_many :inv_line_items
attr_accessible :inv_line_items_attributes
accepts_nested_attributes_for :inv_line_items, :allow_destroy => true
  
def paid_convert 

    paid ? 'Paid' : 'UnPaid'

end
  
end
