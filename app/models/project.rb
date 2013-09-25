class Project < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :supplier, :class_name => "Contact", :foreign_key => "contact_id"
  belongs_to :organization
  belongs_to :tasktype
  belongs_to :project_type
  has_many :comments, :order => 'created_at DESC'
   has_many :pay_periods, dependent: :destroy
  attr_accessible :amount, :contact, :description, :project_name,:project_type_id, :entered_by,:notes,:prq_number, :title, :project_type, :supplier_id, :active,:action_required,
                   :schedule_date, :tasktype_id,:status_details, :analysis ,:per_completed ,:priority, :owner ,:start_date , :end_date, :status_date, :reference
  
  alias_attribute :supplier_id, :contact_id
  has_many :attachments, :dependent => :destroy
  attr_accessible :attachments_attributes
  
  accepts_nested_attributes_for :attachments, :allow_destroy => true #for multiple attachments
  
  has_many :issues, dependent: :destroy 
  has_many :payments, dependent: :destroy
  validates_presence_of :supplier_id 
  has_many :time_records, dependent: :destroy
  has_and_belongs_to_many :statusreports
  has_and_belongs_to_many :project_reports
   before_save :update_amount
   before_update :update_amount
   def update_amount
    self.amount ||= 0.0
   end
 
end
