# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
set :output, "/home/huangzhi/sites/rubyslide.com/production/shared/log/cron_log.log"

every 12.hours, :at => "6:00" do
  rake "slideshare"
end
