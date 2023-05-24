# opensearch.rb

package 'opensearch' do
  action :install
end

template '/etc/opensearch/opensearch.yml' do
  source 'opensearch.yml.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    option1: node['opensearch']['option1'],
    option2: node['opensearch']['option2']
    # ... 可以根据需要添加更多变量
  )
  notifies :restart, 'service[opensearch]', :delayed
end

service 'opensearch' do
  action [:enable, :start]
end
