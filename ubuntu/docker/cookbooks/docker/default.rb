username = node['username'] || 'ubuntu'

execute "download and install docker" do
  command "curl -sSL https://get.docker.com | sh"
end

execute "usermod -aG docker #{username}"

service :docker do
  action [:enable, :restart]
end
