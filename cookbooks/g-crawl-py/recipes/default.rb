#
# Cookbook Name:: g-crawl-py
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
gem_package "debugger"
gem_package "sinatra"
gem_package "haml"
gem_package "will_paginate"
gem_package "active_support"
gem_package "vegas"
gem_package "qless"
package "python-dev"#needed for Python.h when compiling hiredis
#package "python-pip" #default action is install so this is a short form of:
package "python-pip" do
    action :install
end


package "libxml2-dev"
package "libxslt-dev"
python_pip "lxml" do #needed by qless-py
    action :install
end

#alternatively just use the redisio recipe/cookbook
package 'libhiredis-dev'
package 'libevent-dev' #for event.h needed by gevent
python_pip "redis" do #needed by qless-py
    action :install
end

python_pip "hiredis" do
    action :install
end

python_pip "psutil" do #qless-py seems to rely on this
    action :install
end

git "/home/ubuntu/pyreBloom" do
    repository "https://github.com/trtg/pyreBloom.git"
    reference "master"
    action :sync
end

#figure out how to make this idempotent- use conditional?
execute "pyreBloomInstall" do
    command "cd /home/ubuntu/pyreBloom/;
    sudo python setup.py install"
    action :run
end

#ruby version of qless but necessary lua files
#appear to be in qless-core repo- does that need 
#to checked out in the lib directory manually?
git "/home/ubuntu/qless" do
    repository "https://github.com/trtg/qless.git"
    reference "master"
    action :sync
end

git "/home/ubuntu/qless-py" do
    repository "https://github.com/trtg/qless-py.git"
    reference "master"
    action :sync
end

git "/home/ubuntu/qless-py/qless/qless-core" do
    repository "https://github.com/trtg/qless-py.git"
    reference "master"
    action :sync
end


execute "qlessPyInstall" do
    command "cd /home/ubuntu/qless-py/;
    sudo python setup.py install"
    action :run
end

git "/home/ubuntu/crawler" do
    repository "https://github.com/trtg/g-crawl-py.git"
    reference "master"
    action :sync
end

execute "crawlerInstall" do
    command "cd /home/ubuntu/crawler/;
    sudo python setup.py install"
    action :run
end

#figure out how to dynamically pass in the node 
#currently in the role of qless_server as the value of --host
execute "runCrawler" do
    command "qless-py-worker --host 54.234.146.86 --path /home/ubuntu/crawler/ -q crawl --verbose --interval 5 > /tmp/crawler.log &"
    action :run
end
