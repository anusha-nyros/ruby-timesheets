class Link < ActiveRecord::Base
  attr_accessible :link, :notes, :pwd_hint, :product, :user_name, :sharebox, :share_option, :user_id
  belongs_to :organization
  validates_presence_of :product
  #validates_format_of :link, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix , :allow_blank => true
  belongs_to :user
  has_many :linkimages, :dependent => :destroy
  attr_accessible :linkimages_attributes
  accepts_nested_attributes_for :linkimages, :allow_destroy => true

end
