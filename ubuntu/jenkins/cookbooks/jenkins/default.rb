
execute "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -"

execute "sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'"

execute "sudo apt update -Y"

execute "sudo apt install jenkins -Y"

execute "sudo systemctl daemon-reload"

execute "sudo systemctl start jenkins"

