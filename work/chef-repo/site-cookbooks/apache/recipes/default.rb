#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#



# Package resource
package "httpd" do # Name of the package to install
  action :install # Install a package - if version is provided, install that specific version (Default)
end

user "apache" do
  action :create
end

group "apache" do
  members "apache"
  action :create
end

template "/etc/httpd/conf/httpd.conf" do # Path to the file
  source  'httpd.conf.erb'  # Template source file. Found in templates/default for the cookbook
  owner 'apache'  # The owner for the file
  group 'apache' # The group owner of the file (string or id)
  mode '0644' # The octal mode of the file (4-digit format)
  notifies :reload, 'service[httpd]'
end

# Service resource
service "httpd" do # Name of the service
  supports :reload => true, :restart=> true ,:status => true # Features this service supports, ie :restart, :reload, :status
  action [:enable ,:start]   # Enable this service
end
