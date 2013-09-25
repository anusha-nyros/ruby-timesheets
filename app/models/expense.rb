class Expense < ActiveRecord::Base
  attr_accessible :amount, :approved_date,:expensetype_id, :date, :description, :exp_number, :status, :username, :expense_type, :contact_type, :reference
  belongs_to :organization
  belongs_to :user
  belongs_to :expensetype
   #validates_presence_of :amount
 #for expense attachments 

  has_many :expense_attachments, :dependent => :destroy
  attr_accessible :expense_attachments_attributes
  accepts_nested_attributes_for :expense_attachments, :allow_destroy => true

 # for payment menthod
  has_many :payments, :dependent => :destroy	
  attr_accessible :payments_attributes
  accepts_nested_attributes_for :payments, :allow_destroy => true


end


  
