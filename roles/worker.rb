name "worker"
description "Worker Node that polls qless queues for work to do"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[worker]","recipe[chef-client]","recipe[nagios]"
