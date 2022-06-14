# frozen_string_literal: true

include_recipe "../apt/add_repositories_setup"
include_recipe "./attribute"

# variables
tailscale = node.fetch(:tailscale, {})

# install raspiberry os tailscale (for buster version)
execute "install tailscale repository" do
  command %[
    curl -fsSL https://pkgs.tailscale.com/stable/raspbian/buster.gpg | sudo apt-key add -
    curl -fsSL https://pkgs.tailscale.com/stable/raspbian/buster.list | sudo tee /etc/apt/sources.list.d/tailscale.list
  ]
end

execute "apt-get update"

# install tailscale
package "tailscale"

# authenticate
if tailscale[:auth_key]
  execute "tailscale authentication" do
    command "tailscale up --auth-key #{tailscale[:auth_key]}"
  end

  execute "tailscale ip -4"
end
