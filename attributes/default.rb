default[:opsworks_consul][:layers][:cluster] = 'consul'
default[:opsworks_consul][:layers][:bootstrap] = 'consul-bootstrap'

set[:consul][:serve_ui] = true

bootstrap_layer = default[:opsworks_consul][:layers][:bootstrap]
cluster_layer = default[:opsworks_consul][:layers][:cluster]

if node[:opsworks][:instance][:layers].include?(bootstrap_layer)
  set[:consul][:service_mode] = 'bootstrap'
else
  set[:consul][:service_mode] = 'cluster'
  set[:consul][:bootstrap_expect] = 2 # make sure our cluster nodes are not started as bootstrap

  servers_layer = bootstrap_layer

  # If there's already provisioned cluster nodes, use those instead of the bootstrap node
  if node[:opsworks][:layers][cluster_layer][:instances].length > 0
    servers_layer = cluster_layer
  end

  set[:consul][:servers] = node[:opsworks][:layers][servers_layer][:instances].map do |name, instance|
    instance[:private_ip]
  end
end
