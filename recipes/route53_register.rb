if not node[:opsworks_consul][:route_53][:zone_id].nil?
  include_recipe "route53"

  record = "#{node[:opsworks][:instance][:hostname]}.#{node[:opsworks_consul][:route_53][:domain]}"

  route53_record record do
    name record
    value node[:opsworks][:instance][:private_ip]
    type "A"
    zone_id node[:opsworks_consul][:route_53][:zone_id]
    overwrite true
    action :create
  end
end
