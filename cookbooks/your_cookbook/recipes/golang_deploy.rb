file '/path/to/your/golang/app' do
  mode '0755'
  owner 'root'
  group 'root'
  content lazy { ::File.open('/path/to/your/golang/app').read }
  action :create
end

remote_file '/path/on/remote/server/golang_app' do
  source 'file:///path/to/your/golang/app'
  owner 'remote_user'
  group 'remote_group'
  mode '0755'
  action :create
end

file '/path/to/your/config.yml' do
  mode '0644'
  owner 'root'
  group 'root'
  content lazy { ::File.open('/path/to/your/config.yml').read }
  action :create
end

remote_file '/path/on/remote/server/config.yml' do
  source 'file:///path/to/your/config.yml'
  owner 'remote_user'
  group 'remote_group'
  mode '0644'
  action :create
end
  