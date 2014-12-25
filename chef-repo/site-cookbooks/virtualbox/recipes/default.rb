#
# Cookbook Name:: virtualbox
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
version = node['virtualbox']['version']
cpubit = node['virtualbox']['cpubit']
remote_file "#{Chef::Config[:file_cache_path]}/epel-release.rpm" do
  source node['virtualbox']['rpmforgeurl']
end

remote_file "/etc/yum.repos.d/virtualbox.repo" do
  source "http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo"
end

rpm_package "#{Chef::Config[:file_cache_path]}/epel-release.rpm" do
  action :install
end

# Package resource
["rpmforge-release","dkms","VirtualBox-#{version}.#{cpubit}"].each do |packagename|
  package packagename do 
    action :upgrade
  end
end 

group 'vboxusers' do
  append true
  members "vagrant"
  action :modify
end
