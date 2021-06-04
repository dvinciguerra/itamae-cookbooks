
system_name = `lsb_release -si | tr \'[:upper:]\' \'[:lower:]\'`
system_version = "bionic"

# configure repositories
execute 'wget -qO- https://repos.influxdata.com/influxdb.key | apt-key add -'
execute 'wget -qO- https://packages.grafana.com/gpg.key | apt-key add -'

execute "echo \"deb https://repos.influxdata.com/#{system_name} #{system_version} stable\" > /etc/apt/sources.list.d/influxdb.list"
execute 'add-apt-repository "deb https://packages.grafana.com/oss/deb stable main" -y'

execute 'apt update -y'

# install telegraf
execute 'apt install telegraf -y'
service 'telegraf' do
  action [ :enable, :start ]
end

# install influxdb
execute 'apt install influxdb -y'
service 'influxdb' do
  action [ :enable, :start ]
end

# install grafana
execute 'apt install grafana -y'
service 'grafana-server' do
  action [ :enable, :start ]
end


# configure influxdb
# influx
#
# > create database telegrafdb
# > create user telegraf with password 'password'
# > grant all on telegrafdb to telegraf
# > show databases
# > show users
# > exit


# configure telegraf agent
execute 'telegraf config -input-filter cpu:mem:swap:system:processes:disk -output-filter influxdb > /etc/telegraf/telegraf.conf'

# vim /etc/telegraf/telegraf.conf
#
# [[outputs.influxdb]]
# urls = ["http://127.0.0.1:8086"]
# database = "telegrafdb"
# username = "telegraf"
# password = "password"

execute 'systemctl restart telegraf'

execute 'telegraf --config /etc/telegraf/telegraf.conf --test'

# reset admin password
execute 'grafana-cli admin reset-admin-password mynewpassword'
