name "qless_server"
description "Node that crawls websites and writes out page bodies to a data store"
run_list "recipe[git]","recipe[build-essential]","recipe[qless]"
