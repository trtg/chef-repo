name "crawler"
description "Node that crawls websites and writes out page bodies to a data store"
run_list "recipe[apt]","recipe[build-essential]","recipe[git]","recipe[g-crawl-py]"
