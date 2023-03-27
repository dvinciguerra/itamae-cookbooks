# frozen_string_literal: true

def time_current
  Time.now.strftime('%Y%m%d%H%M%S')
end

node.reverse_merge!(
  portainer: {
    name: 'portainer',
    image: 'portainer/portainer-ce:latest',
    backup: {
      enable: true,
      source: '/var/lib/docker/volumes/portainer_data',
      destination: "/opt/#{time_current}-portainer"
    },
    ports: [
      [8000, 8000],
      [9443, 9443]
    ],
    volumes: [
      ['/var/run/docker.sock', '/var/run/docker.sock'],
      ['portainer_data', '/data']
    ]
  }
)

portainer =
  node[:portainer]

ports =
  portainer[:ports].map { |item| "-p #{item.join(':')} " }

volumes =
  portainer[:volumes].map { |item| "-v #{item.join(':')} " }

if portainer[:backup][:enable]
  execute 'backup portainer volume directory' do
    command "cp -R #{portainer[:backup][:source]} #{portainer[:backup][:destination]}"
    not_if "test -d #{portainer[:backup][:destination]}"
  end
end

execute 'stop container execution' do
  command 'docker stop portainer && docker rm portainer'
end

execute 'pull latest portainer version' do
  command 'docker pull portainer/portainer-ce:latest'
end

execute 'start portainer container again' do
  command "docker run -d #{ports} --name=#{portainer[:name]} --restart=always #{volumes} #{portainer[:image]}"
end
