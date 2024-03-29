# frozen_string_literal: true

execute "enable en_US locale.gen" do
  command "sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen"
  not_if 'test "$LC_ALL" == "en_US.UTF-8"'
end

execute "exec locale-gen" do
  command "locale-gen en_US.UTF-8 && update-locale en_US.UTF-8"
  not_if 'test ("$LC_ALL" == "en_US.UTF-8")'
end

