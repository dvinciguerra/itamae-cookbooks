execute 'add influxdata packages repository' do
  command '
wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/os-release
echo "deb https://repos.influxdata.com/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
  '
end

execute 'update apt packages' do
  command 'apt update'
end

execute 'install telegraf' do
  command 'apt-get install -y telegraf'
end

execute 'enable telegraf service' do
  command 'systemctl enable telegraf'
end

execute 'start telegraf service' do
  command 'systemctl start telegraf'
end
