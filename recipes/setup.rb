include_recipe 'consul'
include_recipe 'consul::ui'
include_recipe 'opsworks_consul::route53_register'
