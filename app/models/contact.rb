class Contact < ActiveRecord::Base
  has_many :projects
  belongs_to :user
  has_many :meetings
  has_many :account_histories
  belongs_to :organization
  mount_uploader :photo, PhotoUploader 
  attr_accessible :active, :photo, :phone, :mobile_phone, :address ,:fax, :website,:skype, :fb, :linkedin , :chat_tool, :company, :contact, :contact_type, :email, :notes, :organization, :username   
  attr_accessor :username
  


  has_and_belongs_to_many :skills
  has_and_belongs_to_many :project_types
  has_and_belongs_to_many :groups
  validates :contact_type, presence: true, inclusion: { :in => %w{ contact client supplier employee associate contractor } }
  validates_presence_of :organization_id
  validate :assign_user
  validates :email, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  
  
  protected
  def assign_user
    if username.present?      
      self.user = User.find_by_username(self.username)      
      errors.add(:username, "is not a valid user on database") if self.user.blank?
    end
  end
end
