# my_opensearch_cookbook/recipes/default.rb

# 遍历服务器列表
node['my_opensearch_cookbook']['servers'].each do |server|
  # 部署 OpenSearch
  opensearch_installation 'opensearch' do
    version node['my_opensearch_cookbook']['opensearch_version']
    action :install
  end

  # 创建 OpenSearch 配置文件
  template "/etc/opensearch/opensearch.yml" do
    source 'opensearch.yml.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables node['my_opensearch_cookbook']['opensearch_config']
    notifies :restart, 'service[opensearch]', :delayed
  end

  # 部署 OpenSearch-Dashboards
  opensearch_installation 'opensearch-dashboards' do
    version node['my_opensearch_cookbook']['opensearch_dashboards_version']
    action :install
  end

  # 创建 OpenSearch-Dashboards 配置文件
  template "/etc/opensearch-dashboards/opensearch-dashboards.yml" do
    source 'opensearch-dashboards.yml.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables node['my_opensearch_cookbook']['opensearch_dashboards_config']
    notifies :restart, 'service[opensearch-dashboards]', :delayed
  end
end
