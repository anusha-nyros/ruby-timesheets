class ProjectReport < ActiveRecord::Base
belongs_to :organization
 has_and_belongs_to_many :projects
  # attr_accessible :title, :body
end
