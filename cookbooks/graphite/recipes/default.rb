#
# Cookbook Name:: graphite
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "py27-whisper"
package "py27-carbon"
package "py27-graphite-web"

template "/usr/local/etc/carbon/carbon.conf" do
  source "carbon.conf.erb"
  owner "root"
  group "wheel"
  mode 0644
  notifies :restart, "service[carbon]"
end

service "carbon" do
  action [:enable, :start]
  supports [:enable, :start, :stop, :restart]
end