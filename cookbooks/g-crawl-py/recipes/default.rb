#
# Cookbook Name:: g-crawl-py
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "python-dev"#needed for Python.h when compiling hiredis
#package "python-pip" #default action is install so this is a short form of:
package "python-pip" do
    action :install
end

python_pip "hiredis" do
    action :install
end

git "/home/ubuntu/pyreBloom" do
    repository "https://github.com/trtg/pyreBloom.git"
    reference "master"
    action :sync
end

git "/home/ubuntu/crawler" do
    repository "https://github.com/trtg/g-crawl-py.git"
    reference "master"
    action :sync
end

