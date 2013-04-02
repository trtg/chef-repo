#
# Cookbook Name:: worker
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

#In case you need to debug this interactively:
#gem install chef
# irb>
#require 'rubygems'
#require 'chef'
#Chef::Config.from_file('/etc/client.rb')
role_query = Chef::Search::Query.new
final_address=[]

role_query.search(:node,'role:fat_node') do | h|
    fat_node_mac_address = h.ec2['network_interfaces_macs'].keys[0]
    fat_node_public_ip_address = h.ec2['network_interfaces_macs'][fat_node_mac_address]['public_ipv4s']
    final_address =fat_node_public_ip_address
end

puts "starting worker using #{final_address} as the queue server"

execute "runCrawler" do
    command "cd /home/ubuntu/cloud_crawler/cloud-crawler;
    bundle exec /home/ubuntu/cloud_crawler/cloud-crawler/bin/start_batch_crawl.rb -h #{final_address} &"
    action :run
end

#TODO: start another worker that polls the queue residing in the local redis instance, 
#or make the single worker watch both queues?

