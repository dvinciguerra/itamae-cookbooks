# frozen_string_literal: true

# schema validation
node.validate! do
  {
    hostname: string,
  }
end

# defaults
node.reverse_merge!(
  hostname: "raspberrypi",
  hosts: {}
)

# setting hostname
execute "hostname #{node[:hostname]}" do
  not_if "test [$(hostname) == '#{node[:hostname]}']"
end

# add hosts
if node[:hosts].any?
  pp node[:hosts]
  template "/etc/hosts" do
    action :create
    source "./templates/hosts.erb"
  end
end
