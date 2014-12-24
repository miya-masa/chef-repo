#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# SCM Resource, Chef::Provider::Git
git "/home/vagrant/.rbenv" do # Path to clone/checkout/export the source to
  repository "https://github.com/sstephenson/rbenv.git"
  reference "master" # (Git only) alias for revision
  user "vagrant" # System user to own the checked out code
  group "vagrant"  # System group to own the checked out code
  action :sync # Update the source to the specified revision, or get a new clone (Default)
end
# Directory resource
directory "/home/vagrant/.rbenv/plugins/" do # The path to the directory
  group "vagrant" # The group owner of the directory (string or id)
  owner "vagrant"  # The owner for the directory
  mode "0755"  # The octal mode of the directory, eg 0755
end

git "/home/vagrant/.rbenv/plugins/ruby-build" do # Path to clone/checkout/export the source to
  repository "https://github.com/sstephenson/ruby-build.git"
  reference "master" # (Git only) alias for revision
  user "vagrant" # System user to own the checked out code
  group "vagrant"  # System group to own the checked out code
  action :sync # Update the source to the specified revision, or get a new clone (Default)
end
bash "set echo rbenv" do
  cwd "/home/vagrant/"
  environment 'HOME' => "/home/vagrant/"
  user "vagrant"
  group "vagrant"
  not_if "grep rbenv /home/vagrant/.bash_profile"
  code <<-EOH 
  echo 'export PATH="/home/vagrant/.rbenv/bin:$PATH"' >> /home/vagrant/.bash_profile
  EOH
end

bash "install_ruby" do
  cwd "/home/vagrant/"
  environment 'HOME' => "/home/vagrant/"
  user "vagrant"
  group "vagrant"
  code <<-EOH 
    /home/vagrant/.rbenv/bin/rbenv install 2.1.5
  EOH
end
