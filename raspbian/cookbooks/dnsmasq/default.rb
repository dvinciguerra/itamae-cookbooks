# frozen_string_literal: true

package "dnsmasq"

service "dnsmasq" do
  action [:enable]
end
