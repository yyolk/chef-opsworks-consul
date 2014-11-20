default[:opsworks_consul][:layers][:cluster] = 'consul'
default[:opsworks_consul][:layers][:bootstrap] = 'consul-bootstrap'

bootstrap_layer = default[:opsworks_consul][:layers][:bootstrap]

if node[:opsworks][:instance][:layers].include?(bootstrap_layer)
  set[:consul][:service_mode] = 'bootstrap'
else
  set[:consul][:service_mode] = 'cluster'
  set[:consul][:bootstrap_expect] = 2 # make sure our cluster nodes are not started as bootstrap
end

set[:consul][:servers] = node[:opsworks][:layers][bootstrap_layer].map do |name, instance|
  instance[:private_ip]
end
