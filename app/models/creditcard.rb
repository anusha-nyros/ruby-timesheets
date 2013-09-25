class Creditcard < ActiveRecord::Base
  attr_accessible :expiryon, :number, :organization_id, :user_id
  validates_presence_of :number 
  validates_length_of :number, minimum:16, maximum: 16 
  belongs_to :user
  belongs_to :organization
end
