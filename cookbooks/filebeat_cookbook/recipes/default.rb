#

# Cookbook Name:: filebeat_cookbook
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

directory node['filebeat_cookbook']['filebeat_directory'] do

	action :create
end
remote_file node['filebeat_cookbook']['remote_directory'] do
	source node['filebeat_cookbook']['download_url']
	action :create
end

dpkg_package 'filebeat' do
	source  node['filebeat_cookbook']['filebeat_source_directory']
	action :install
end

template node['filebeat_cookbook']['template_replace_directory'] do
	source node['filebeat_cookbook']['template_source']
	variables({
		source: node['filebeat_cookbook']['source_log_directory'],
		sink: node['filebeat_cookbook']['elasticsearch_endpoint_url'],
		index: node['filebeat_cookbook']['elasticsearch_index']
	})
end

service 'filebeat' do
	start_command 'sudo /etc/init.d/./filebeat restart'	
	action :restart
end	
