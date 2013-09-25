class LinkAccount < ActiveRecord::Base
  attr_accessible :accept, :ignor, :remove, :request, :source, :source_admin_id, :source_id, :target, :target_admin_id, :target_id
end
