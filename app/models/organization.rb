class Organization < ActiveRecord::Base
  attr_accessible :name, :account_type
  
  validates_presence_of :name
  validates_presence_of :account_type
  validates :account_type, inclusion: { :in => %w( project ) }, presence: true
  has_many :invoices, dependent: :destroy    
  has_many :users, dependent: :destroy
  has_many :account_histories, dependent: :destroy
  has_many :pay_periods, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :meetings ,dependent: :destroy
  has_many :project_types, dependent: :destroy
  has_many :statuses, dependent: :destroy
  has_many :timecodes, dependent: :destroy
  has_many :attendees, dependent: :destroy
  has_many :statusreports ,dependent: :destroy
  has_many :my_threads ,dependent: :destroy
  has_many :thread_comments ,dependent: :destroy
  has_many :expenses ,dependent: :destroy
  has_many :project_reports , dependent: :destroy
  has_many :calendars, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :tasktypes ,dependent: :destroy
  has_many :expensetypes ,dependent: :destroy
  has_many :projecttypes ,dependent: :destroy
  has_many :issuetypes ,dependent: :destroy
  has_many :issues, dependent: :destroy
  has_one  :creditcard, dependent: :destroy

  #ozzcat
  has_one :link
  has_many :pay_periods, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :folders
end
