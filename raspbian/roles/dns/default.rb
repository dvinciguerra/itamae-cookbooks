# frozen_string_literal: true

include_recipe "../../cookbooks/lang"
include_recipe "../../cookbooks/dnsmasq"
include_recipe "../../cookbooks/hosts"

# prepare dnsmasq to be local name server
file "/etc/dnsmasq.conf" do
  action :edit
  user "root"
  block do |content|
    content.gsub!("#bogus-priv", "bogus-priv")
    content.gsub!("#domain-needed", "domain-needed")
    content << <<~CONFIG
      server=1.1.1.1
      server=8.8.8.8

      cache-size=1000
    CONFIG
  end
  not_if 'test "$(cat /etc/dnsmasq.conf | grep \'server=1.1.1.1\')"'
end

# restart dnsmasq
service 'dnsmasq' do
  action [:restart]
end

