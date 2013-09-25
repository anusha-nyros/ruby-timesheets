class Expensetype < ActiveRecord::Base
  attr_accessible :expensetype, :organization_id, :usage
  has_many :expenses ,dependent: :destroy 
  belongs_to :organization
  validates_presence_of :expensetype
end
