class Attachment < ActiveRecord::Base
  attr_accessible :doc, :project_id,:content_type
   mount_uploader :doc, DocUploader
  
  belongs_to :project
before_save :update_asset_attributes
  
  private
  
  def update_asset_attributes
    if doc.present? && doc_changed?
      self.content_type = doc.file.content_type

    end
  end
end
