namespace :sample do
  desc "Run user email notifications  "
    task :run => :environment do
      puts "begin the user list who are admins of an organization "
       users = User.find_by_sql("select * from users where admin = 1 ")

       users.each do |m|
       c  = (DateTime.now - m.created_at.to_date).to_i
       if c == 7 && m.email_status_reminder != 1
        puts "you have #{m.username} completed one week"
        StatusMailer.reminder_email_week1(m).deliver
        m.update_attribute("email_status_reminder",1)
       end 
       if c == 14 && m.email_status_reminder != 2
         puts "You have  #{m.username} completed two weeks "
         StatusMailer.reminder_email_week2(m).deliver
         m.update_attribute("email_status_reminder",2)
        end 
         if c == 21 && m.email_status_reminder != 3
          puts "You have  #{m.username} Completed three weeks "
          StatusMailer.reminder_email_week3(m).deliver
          m.update_attribute("email_status_reminder",3)
        end 
       end 
    end 
end