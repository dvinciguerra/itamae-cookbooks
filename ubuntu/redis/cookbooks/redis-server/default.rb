
# install redis
execute 'apt install redis-server -y'

# setup
file '/etc/redis/redis.conf' do
  action :edit
  block do |content|
    content << "supervised systemd"
  end
end

# enable and start service
service 'redis' do
  action [:enable, :start]
end
