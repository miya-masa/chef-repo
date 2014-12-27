
# ruby that will get installed and set to `rvm use default`.
default['vagrant']['version'] = "1.7.1"
default['vagrant']['cpubit'] = "x86_64"
default['vagrant']['httpproxy'] = ""
default['vagrant']['httpsproxy'] = ""
default['vagrant']['boxname'] = 'centos6.5' 
default['vagrant']['boxurl'] = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box'
