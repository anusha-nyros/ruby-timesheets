class ExpenseAttachment < ActiveRecord::Base
  attr_accessible :doc, :expense_id
  mount_uploader :doc, ExpenseAttachmentUploader 
  belongs_to :expense

end
