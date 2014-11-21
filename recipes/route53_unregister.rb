if not node[:opsworks_consul][:route53][:zone_id].nil?
  include_recipe "route53"

  record = "#{node[:opsworks][:instance][:hostname]}.#{node[:opsworks_consul][:route53][:domain]}"

  route53_record record do
    name record
    type "A"
    zone_id node[:opsworks_consul][:route53][:zone_id]
    action :delete
  end
end
