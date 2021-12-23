dns = node['dns']

include_recipe '../cookbooks/setup'
include_recipe '../cookbooks/unbound'
include_recipe '../cookbooks/telegraf'

execute "setting hostname #{dns['hostname']}" do
  command "hostnamectl set-hostname #{dns['hostname']}"
  not_if "test $(hostname) = #{dns['hostname']}"
end

template '/etc/dhcpcd.conf' do
  source './dhcpcd.conf.erb'
  variables(node: node)
end

execute 'Add my host to /etc/hosts' do
  not_if "grep #{node['hostname']} /etc/hosts"
  user 'root'
  command "echo 127.0.1.1 #{node['hostname']} >> /etc/hosts"
end

