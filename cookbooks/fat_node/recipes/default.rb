#
# Cookbook Name:: fat_node
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
include_recipe 's3cmd'
include_recipe 'redisio'
include_recipe 'redisio::install'
include_recipe 'redisio::enable'
package "ruby1.9.1"
package "ruby1.9.1-dev"
package "libxslt-dev"#nokogiri dependency
package "libxml2-dev"#nokogiri dependency

gem_package "bundler"

git "/home/ubuntu/cloud_crawler" do
    repository "https://github.com/charlesmartin14/cloud_crawler.git"
    reference "master"
    action :sync
end

execute "crawlerInstall" do
    command "cd /home/ubuntu/cloud_crawler/cloud-crawler;
    bundle install;gem build cloud_crawler.gemspec; gem install cloud_crawler*.gem"
    action :run
end


