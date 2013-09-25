class InvLineItem < ActiveRecord::Base
  attr_accessible :amount, :description, :extended, :invoice_id, :quantity, :reference, :text_comment, :unit
belongs_to :invoice  

end
