package "ap24-mod_wsgi3"

service "apache24" do
  action :enable
  supports [:restart]
end

template "/usr/local/etc/apache24/Includes/graphite.conf" do
  source "graphite.conf.erb"
  owner "root"
  group "wheel"
  mode 0644
  variables( :hostname => "graphite.unwiredcouch.com",
             :graphite_root => "/usr/local/share/graphite-web",
             :wsgi_path => "/usr/local/etc/graphite",
             :django_root => "/usr/local/lib/python2.7/site-packages/django/"
           )
  notifies :restart, "service[apache24]"
end

dashboards_dir = "/usr/local/www/dashboards/"

directory dashboards_dir do
  owner "www"
  group "wheel"
  mode 0775
end

template "/usr/local/etc/graphite/local_settings.py" do
  source "local_settings.py.erb"
  owner "root"
  group "wheel"
  mode 0644
end

template "/usr/local/etc/apache24/Includes/dashboards.conf" do
  source "dashboards.conf.erb"
  owner "root"
  group "wheel"
  mode 0644
  variables( :hostname => "dashboards.unwiredcouch.com",
             :docroot => "#{dashboards_dir}/htdocs"
           )
end
