#!/bin/bash

kibanaurl=$1
echo $kibanaurl
kibanauri=$kibanaurl/api/kibana/settings/defaultIndex

curl -XPOST -H 'Content-Type: application/json' -H 'kbn-xsrf: anything' $kibanauri -d'{"value":"heartbeat-*"}'

