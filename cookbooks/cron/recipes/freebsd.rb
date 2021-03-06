cron "portsnap update" do
  user "root"
  minute "0"
  hour "3"
  command "/usr/sbin/portsnap -I cron update"
end

cron "freebsd update" do
  user "root"
  minute "33"
  hour "2"
  command "/usr/sbin/freebsd-update cron"
end

cron "set time via ntpd" do
  user "root"
  minute "0"
  hour "2"
  command "/usr/sbin/ntpdate -s time.google.com"
end
