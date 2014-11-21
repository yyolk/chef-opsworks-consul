execute "service consul stop && rm -rf #{node[:consul][:data_dir]}/{serf,raft,tmp} && service consul start"
