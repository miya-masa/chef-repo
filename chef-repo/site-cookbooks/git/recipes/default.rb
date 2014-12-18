#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Package resource
%w{curl-devel expat-devel gettext-devel openssl-devel zlib-devel cpan gcc asciidoc xmlto}.each do |pkg|
  # Package resource
  package pkg do 
    action :install
  end
end

bash "git install" do # The command to execute
  cwd "/tmp"
  not_if { ::File.exists?("/tmp/git-2.2.0.tar.gz")}
  code <<-EOH
    wget https://www.kernel.org/pub/software/scm/git/git-2.2.0.tar.gz
    tar -zxvf git-2.2.0.tar.gz
    cd git-2.2.0
    make configure
    ./configure --prefix=/usr/local
    make all doc
    make install install-doc install-html
  EOH
end
