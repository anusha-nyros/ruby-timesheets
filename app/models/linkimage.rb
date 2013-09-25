class Linkimage < ActiveRecord::Base
  attr_accessible :link_id, :link_image
  mount_uploader :link_image, LinkImageUploader
  
  before_save :update_link_image_attributes
  
  private
  
  def update_link_image_attributes
    if link_image.present? && link_image_changed?
      self.content_type = link_image.file.content_type
      self.file_size = link_image.file.size
    end
  end
  
  
  belongs_to :link
end
