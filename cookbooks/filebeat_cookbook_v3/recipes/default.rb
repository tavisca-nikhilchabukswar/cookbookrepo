# created by nikhil chabukswar
# Cookbook:: filebeat_cookbook_v3
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

directory node['filebeat_cookbook_v3']['filebeat_directory'] do
	action :create
end
remote_file node['filebeat_cookbook_v3']['remote_directory'] do
		source node['filebeat_cookbook_v3']['download_url']
		action :create
end

dpkg_package 'filebeat' do
		source  node['filebeat_cookbook_v3']['filebeat_source_directory']
		action :install
end

template node['filebeat_cookbook_v3']['template_replace_directory'] do
		source node['filebeat_cookbook_v3']['template_source']
		variables({
				source: node['filebeat_cookbook_v3']['source_log_directory'],
				sink: node['filebeat_cookbook_v3']['elasticsearch_endpoint_url'],
				index: node['filebeat_cookbook_v3']['elasticsearch_index']
			})
end

service 'filebeat' do
		start_command 'sudo /etc/init.d/./filebeat restart'	
		action :restart
end
