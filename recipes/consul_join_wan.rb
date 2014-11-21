wan_servers = node[:opsworks_consul][:wan_servers]

if wan_servers.length > 0
  execute "consul join -wan #{wan_servers.join(' ')}"
else
  log "Could not join another dc cluster because the wan_servers attribute was empty" do
    level :warn
  end
end
