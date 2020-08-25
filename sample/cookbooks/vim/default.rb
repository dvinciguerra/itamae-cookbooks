# frozen_string_literal: true

execute 'update apt' do
  command 'apt -y update'
end

package 'vim' do
  options '--force-yes'
end
