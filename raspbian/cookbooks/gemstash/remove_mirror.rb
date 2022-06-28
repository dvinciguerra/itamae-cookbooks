# frozen_string_literal: true

# remove rubygems mirror
execute "bundle config --delete mirror.https://rubygems.org"
