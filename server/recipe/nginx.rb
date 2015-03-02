package "nginx"

service "nginx" do
  action :enable
end

directory "/etc/nginx/conf.d" do
  owner "root"
  group "root"
  mode  "0755"
end

template "/etc/nginx/conf.d/docker.wakateweb.konboi.com.conf" do
  source 'docker.wakateweb.konboi.com.conf.erb'
end
