# frozen_string_literal: true

# schema validation
node.validate! do
  {
    tailscale: {
      auth_key: optional(string),
    },
  }
end

# defaults
node.reverse_merge!(
  tailscale: {}
)
