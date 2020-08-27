# frozen_string_literal: true

include_recipe '../wget'

execute 'download grafana.deb package' do
  command 'wget https://dl.grafana.com/oss/release/grafana-rpi_6.7.0_armhf.deb'
end

execute 'install grafana.deb' do
  command 'dpkg -i grafana-rpi_6.7.0_armhf.deb'
end

execute 'enable grafana service' do
  command 'systemctl enable grafana-server.service'
end

execute 'start grafana service' do
  command 'systemctl start grafana-server.service'
end
