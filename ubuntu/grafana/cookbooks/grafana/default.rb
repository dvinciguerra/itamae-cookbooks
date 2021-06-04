
# configure repositories
execute 'wget -qO- https://repos.influxdata.com/influxdb.key | gpg --dearmor > /etc/apt/trusted.gpg.d/influxdb.gpg'
execute 'wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -'

execute 'DISTRIB_ID="$(lsb_release -si)" DISTRIB_CODENAME="$(lsb_release -sc)" echo "deb [signed-by=/etc/apt/trusted.gpg.d/influxdb.gpg] https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" > /etc/apt/sources.list.d/influxdb.list'
execute 'sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"'

execute 'sudo apt update -y'

# install telegraf
execute 'sudo apt install telegraf -y'
execute 'sudo systemctl enable --now telegraf'
execute 'sudo systemctl start telegraf'

# install influxdb
execute 'sudo apt install influxdb -y'
execute 'sudo systemctl enable --now influxdb'
execute 'sudo systemctl start influxdb'

# install grafana
execute 'sudo apt install grafana -y'
execute 'sudo systemctl daemon-reload'
execute 'sudo systemctl enable --now grafana-server'
execute 'sudo systemctl start grafana-server'


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
execute 'sudo telegraf config -input-filter cpu:mem:swap:system:processes:disk -output-filter influxdb > /etc/telegraf/telegraf.conf'

# vim /etc/telegraf/telegraf.conf
#
# [[outputs.influxdb]]
# urls = ["http://127.0.0.1:8086"]
# database = "telegrafdb"
# username = "telegraf"
# password = "password"

execute 'sudo systemctl restart telegraf'

execute 'telegraf --config /etc/telegraf/telegraf.conf --test'

# reset admin password
execute 'grafana-cli admin reset-admin-password mynewpassword'
