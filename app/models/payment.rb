class Payment < ActiveRecord::Base
  attr_accessible :date, :exp_description, :paymethod, :vendor ,:expense_id,:project, :task, :amount,:approved_amt, :project_id, :project_type_id,:pay_amount
  belongs_to :expense
  belongs_to :user
  belongs_to :project_type
  belongs_to :project
end

