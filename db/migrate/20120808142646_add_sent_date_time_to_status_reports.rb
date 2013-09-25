class AddSentDateTimeToStatusReports < ActiveRecord::Migration
    def self.up
  
  add_column :statusreports , :sent_date , :datetime
  end
  
  def self.down
   remove_column :statusreports , :sent_date

  end
end
