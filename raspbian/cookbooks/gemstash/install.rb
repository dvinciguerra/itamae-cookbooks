# frozen_string_literal: true

# install gemstash gem
gem_package "gemstash" do
  action :install
end

# start the server
execute "gemstash start"

# configure global bundler mirror
execute "bundle config mirror.https://rubygems.org http://localhost:9292"
execute "bundle config mirror.https://rubygems.org.fallback_timeout true"
execute "bundle config mirror.https://rubygems.org.fallback_timeout 3"
