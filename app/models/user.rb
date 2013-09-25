class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :time_records, :dependent => :destroy
  belongs_to :organization, :counter_cache => true
  has_many :contacts
  has_many :my_threads, dependent: :destroy
  has_many :invoices, dependent: :destroy  
  has_many :thread_comments, dependent: :destroy
  has_many :account_histories, dependent: :destroy  
  has_many :expenses
  has_many :payments
  has_many :downloads, :dependent => :destroy
  has_and_belongs_to_many :orgtabs
  has_one :creditcard
  #ozzcat
  has_many :activities, dependent: :destroy
  has_and_belongs_to_many :categories # categories that user have permission
  has_and_belongs_to_many :folders # folder that user have permission to
  has_many :calendars, :dependent => :destroy
  has_many :links, dependent: :destroy
  has_many :users, dependent: :destroy
  # virtual attribute
  attr_accessor :organization_name
  attr_accessor :account_type
  
  attr_accessible :username, :name, :group, :chosed_plan,:expiry_date, :active, :email, :password, :password_confirmation, :admin, :organization, :as => "admin"
  attr_accessible :username, :name, :group, :chosed_plan, :email, :password, :password_confirmation, :organization_name, :account_type
  
  validate :organization_name_if_no_organization
  validates_presence_of :name
  validates_presence_of :organization 
  #validates :password, :presence => true, :length => { :minimum => 5 }, :confirmation => true
  validates :password, :presence =>true, :confirmation => true, length: { minimum: 5 }, :on => :create
  validates :password, :confirmation => true, length: { minimum: 5 },:on => :update, :unless => lambda{ |user| user.password.blank? }
  validates :username, :uniqueness => true, :presence => true, :format =>  { :with => /^[\w\d]+$/ }, :length => { :minimum => 5 }
  validates :email, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  
  def pay_periods
    raise "User does not have organization" unless organization
    organization.pay_periods
  end
  
 #ozzcat

  def organization_name_if_no_organization
    errors.add(:organization_name, "can't be blank") if (organization && organization.name.blank?) && organization_name.blank?
  end
  
  def all_folders
    raise "User does not have organization" unless organization
    self.organization.folders
  end
  
  def permitted_folders
    raise "User does not have organization" unless organization
    self.organization.folders.where('use_privacy = ? OR (folders.id IN (?))', false, self.folders)
  end
  
  def user_folders
    self.admin? ? all_folders : permitted_folders
  end
  
  def all_categories
    raise "User does not have organization" unless organization
    self.organization.categories
  end
  
  def permitted_categories
    raise "User does not have organization" unless organization
    permitted_folders = self.permitted_folders
    self.organization.categories.joins('LEFT OUTER JOIN folders on folders.id = categories.folder_id').where('(folders.id is NULL OR folders.use_privacy = ? OR folders.id in (?)) AND (categories.use_privacy = ? OR (categories.id IN (?)))', false, permitted_folders, false, self.categories)
  end
  
  def user_categories
    self.admin? ? all_categories : permitted_categories
  end
  
  def all_activities
    raise "User does not have organization" unless organization
    self.organization.activities
  end
  
  def permitted_activities
    raise "User does not have organization" unless organization
    pfolder = self.permitted_folders.pluck(:id)
    
    #binding.pry
    self.organization.activities.joins(:category).joins('LEFT OUTER JOIN folders f on f.id = categories.folder_id').where('(f.id IS NULL OR f.use_privacy = ? OR f.id in (?)) AND (categories.use_privacy = ? OR (categories.id IN (?)))', false,  pfolder, false, self.categories)
  end
  
  def user_activities
    self.admin? ? all_activities : permitted_activities
  end
  def self.email_reminder
       puts "you are into the email reminder method"
       users = User.find_by_sql("select * from users where admin = 1 ")
       users.each do |m|
       c  = (DateTime.now - m.created_at.to_date).to_i
       if c == 7 && m.email_status_reminder != 1
        puts "you have #{m.username} completed one week"
        StatusMailer.reminder_email_week1(m).deliver
        m.update_attribute("email_status_reminder",1)
       end 
       if c == 14 && m.email_status_reminder != 2
         puts "You have  #{m.username} completed two weeks "
         StatusMailer.reminder_email_week2(m).deliver
         m.update_attribute("email_status_reminder",2)
        end 
         if c == 21 && m.email_status_reminder != 3
          puts "You have  #{m.username} Completed three weeks "
          StatusMailer.reminder_email_week3(m).deliver
          m.update_attribute("email_status_reminder",3)
        end 
       end 
  end 


end
