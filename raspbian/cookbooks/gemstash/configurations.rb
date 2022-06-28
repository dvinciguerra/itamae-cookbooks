# frozen_string_literal: true

# schema validation
node.validate! do
  {
    gemstash: {
      host: string,
      fallback_timeout: optional(number),
    },
  }
end

# defaults
node.reverse_merge!(
  gemstash: {
    host: "http://localhost:9292",
    fallback_timeout: 3,
  }
)

# configure global fallback_timeout
execute "bundle config set --global mirror.https://rubygems.org.fallback_timeout 3"

# configure mirror
gemstash = node[:gemstash]

execute "bundle config set --global mirror.https://rubygems.org #{gemstash[:host]}"
execute "bundle config set --global mirror.https://rubygems.org #{gemstash[:host]}"
execute "bundle config set --global mirror.#{gemstash[:host]} #{gemstash[:fallback_timeout]}"
