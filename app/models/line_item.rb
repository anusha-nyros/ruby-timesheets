class LineItem < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :statusreport
end
