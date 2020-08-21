# frozen_string_literal: true

package 'neovim' do
  action :install
end

directory '/home/pi/.config/nvim' do
  action :create
end

execute 'download plug.vim plugin manager' do
  command '
    curl -fLo ~/.config/nvim/autoload/plug.vim \
      --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  '
end

remote_file '/home/pi/.config/nvim/init.vim' do
  action :create
end
