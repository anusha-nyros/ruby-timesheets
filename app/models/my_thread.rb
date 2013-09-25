class MyThread < ActiveRecord::Base
  attr_accessible :creation_date, :description, :title, :user_id, :thread_number
  belongs_to :user
  belongs_to :organization
  validates_presence_of :title
  has_many :thread_comments, dependent: :destroy
 
end
