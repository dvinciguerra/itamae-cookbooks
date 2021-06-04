
# configure repositories
execute 'wget -qO- https://repos.influxdata.com/influxdb.key | apt-key add -'
execute 'wget -qO- https://packages.grafana.com/gpg.key | apt-key add -'

execute 'echo "deb https://repos.influxdata.com/${"$(lsb_release -si)",,} $(lsb_release -sc) stable" > /etc/apt/sources.list.d/influxdb.list'
execute 'add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"'

execute 'apt update -y'

# install telegraf
execute 'apt install telegraf -y'
execute 'systemctl enable --now telegraf'
execute 'systemctl start telegraf'

# install influxdb
execute 'apt install influxdb -y'
execute 'systemctl enable --now influxdb'
execute 'systemctl start influxdb'

# install grafana
execute 'apt install grafana -y'
execute 'systemctl daemon-reload'
execute 'systemctl enable --now grafana-server'
execute 'systemctl start grafana-server'


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
