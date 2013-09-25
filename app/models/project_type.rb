class ProjectType < ActiveRecord::Base
  attr_accessible :type_name,:active,:project_group,:projecttype_id,:proj_desc,:date_created,:start_date,:end_date,:status,:budget_info,:proj_number,:hours_budget,:expense_budget
  validates_presence_of :type_name
  has_and_belongs_to_many :contacts
  belongs_to :organization
  belongs_to :projecttype
  has_many :projects
  has_many :payments, dependent: :destroy
  has_many :issues, dependent: :destroy
  validates_uniqueness_of :type_name, :message => 'Already project is existed.'
end

