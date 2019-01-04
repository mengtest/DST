#!/bin/bash

steamcmd_dir="$HOME/steamcmd" 
install_dir="$HOME/dontstarvetogether_dedicated_server" 
cluster_name="Cluster_1" 
dontstarve_dir="$HOME/.klei/DoNotStarveTogether"

check_for_file "$install_dir/bin" 


cd "$steamcmd_dir" || fail "Missing $steamcmd_dir directory!"
./steamcmd.sh +login anonymous +force_install_dir ../dontstarvetogether_dedicated_server +app_update 343050 validate +quit

cd "$install_dir/bin" || fail 

run_shared=(./dontstarve_dedicated_server_nullrenderer) 
run_shared+=(-console) 
run_shared+=(-cluster "$cluster_name")
run_shared+=(-monitor_parent_process $$)

"${run_shared[@]}" -shard Caves | sed 's/^/Caves:  /' & 
"${run_shared[@]}" -shard Master | sed 's/^/Master: /'
