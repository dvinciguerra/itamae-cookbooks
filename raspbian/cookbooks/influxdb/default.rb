# frozen_string_literal: true

execute 'add influxdata repository' do
  command '
wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/os-release
echo "deb https://repos.influxdata.com/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
  '
end

execute 'update apt packages' do
  command 'apt update'
end

execute 'install influxdb package' do
  command 'apt install -y influxdb'
end

execute 'enable influxdb service' do
  command 'sudo systemctl enable influxdb.service'
end

execute 'start influxdb service' do
  command '
    systemctl unmask influxdb.service
    sudo systemctl start influxdb
  '
end
