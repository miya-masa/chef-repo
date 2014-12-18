#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "vim install" do
  cwd "/tmp/"
  code <<-EOH 
  wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2 
  tar -jvxf vim-7.4.tar.bz2
  cd vim74
  ./configure
  make 
  make install
  EOH
end


# SCM Resource, Chef::Provider::Git
git "/home/vagrant/dotfiles/" do # Path to clone/checkout/export the source to
  repository "https://github.com/miya-masa/dotfiles.git" # URI of the repository
  user "vagrant"
  group "vagrant"
  revision "master" # revision to checkout. can be symbolic, like "HEAD" or an SCM specific revision id
  action :sync # Update the source to the specified revision, or get a new clone (Default)
end

bash "dotfiles.sh" do
  cwd "/home/vagrant/dotfiles/"
  user "vagrant"
  group "vagrant"
  code <<-EOH 
  chmod 744 dotFilesLink.sh
  sudo -u vagrant ./dotFilesLink.sh
  EOH
end
