#
# Cookbook Name:: vagrant
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
version = node['vagrant']['version']
cpubit = node['vagrant']['cpubit']
http_proxy = node['vagrant']['httpproxy']
https_proxy = node['vagrant']['httpsproxy']
boxname = node['vagrant']['boxname']
boxurl = node['vagrant']['boxurl']

remote_file "#{Chef::Config[:file_cache_path]}/vagrant.rpm" do
  source "https://dl.bintray.com/mitchellh/vagrant/vagrant_#{version}_#{cpubit}.rpm"
end

rpm_package "#{Chef::Config[:file_cache_path]}/vagrant.rpm" do
  action :install
end

bash "box_add" do
  not_if "vagrant box list | grep #{boxname}"
  environment {"HOME" => "/home/vagrant"}
  user "vagrant"
  code <<-EOH
  export http_proxy=#{http_proxy}
  export https_proxy=#{https_proxy}
  vagrant box add #{boxname} #{boxurl}
  EOH
end
