# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
#/home/ubuntu/ruby_applications/timesheets

set :path, '/home/ubuntu/ruby_applications/timesheets'
set :environment, :development
set :output , '/home/ubuntu/ruby_applications/timesheets/error.log'
every '0 1 * * *' do
  runner "User.email_reminder"
end
