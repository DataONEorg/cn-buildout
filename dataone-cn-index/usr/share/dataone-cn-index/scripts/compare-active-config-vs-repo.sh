#!/bin/bash

# will use the first command line argument for the URL of the
# remote directory (within dataone repository)
args=("$@")
repoUrl=${args[0]}

activeConfigs="/etc/dataone/index/index-generation-context"
for i in $( ls ${activeConfigs}); do
    echo " "
    echo item: $i
    echo "< ${repoUrl}"
    echo "> ${activeConfigs}"
    curl ${repoUrl}/$i | diff -w - ${activeConfigs}/$i
done

