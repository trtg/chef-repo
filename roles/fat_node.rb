name "fat_node"
description "Worker Node that polls qless queues for work to do"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[fat_node]","recipe[chef-client]","recipe[nagios]"
