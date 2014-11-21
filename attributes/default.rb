default[:opsworks_consul][:route53][:zone_id] = nil
default[:opsworks_consul][:route53][:domain] = 'region.aws.company.com'
default[:opsworks_consul][:wan_servers] = []

set[:consul][:serve_ui] = true
set[:consul][:service_mode] = 'cluster'
set[:consul][:servers] = node[:opsworks][:layers][:consul][:instances].map do |name, instance|
  instance[:private_ip]
end
