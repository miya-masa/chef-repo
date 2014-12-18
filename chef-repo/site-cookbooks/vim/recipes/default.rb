#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
vim_version = node['vim']['version']
remote_file "/tmp/vim-#{vim_version}.tar.bz2" do
  source "http://ftp.vim.org/pub/vim/unix/vim-#{vim_version}.tar.bz2"
  not_if "::File.exists?(/usr/local/bin/vim)"
  notifies :run, "bash[install_vim]", :immediately
end
bash "install_vim" do
  cwd "/tmp/"
  code <<-EOH 
  mkdir vim-#{vim_version}
  tar -jvxf vim-#{vim_version}.tar.bz2 -C vim-#{vim_version} --strip-components 1
  cd vim-#{vim_version}
  ./configure
  make 
  make install
  EOH
end


## SCM Resource, Chef::Provider::Git
#git "/home/vagrant/dotfiles/" do # Path to clone/checkout/export the source to
#  repository "https://github.com/miya-masa/dotfiles.git" # URI of the repository
#  user "vagrant"
#  group "vagrant"
#  revision "master" # revision to checkout. can be symbolic, like "HEAD" or an SCM specific revision id
#  action :sync # Update the source to the specified revision, or get a new clone (Default)
#end
#
#bash "dotfiles.sh" do
#  cwd "/home/vagrant/dotfiles/"
#  user "vagrant"
#  group "vagrant"
#  code <<-EOH 
#  chmod 744 dotFilesLink.sh
#  su - vagrant 
#  bash ./dotFilesLink.sh
#  EOH
#end
