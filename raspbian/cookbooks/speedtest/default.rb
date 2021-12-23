# frozen_string_literal: true

execute 'install dependecies for speedtest' do
  command 'apt install gnupg1 apt-transport-https dirmngr -y'
end

execute 'add speedtest package repo' do
  command '
export INSTALL_KEY=379CE192D401AB61
export DEB_DISTRO=$(lsb_release -sc)
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $INSTALL_KEY
echo "deb https://ookla.bintray.com/debian ${DEB_DISTRO} main" | sudo tee /etc/apt/sources.list.d/speedtest.list
  '
  not_if 'test -e /etc/apt/sources.list.d/speedtest.list'
end

execute 'update apt packages' do
  command 'apt update -y'
end

execute 'install speedtest package' do
  command 'apt install speedtest -y'
end
