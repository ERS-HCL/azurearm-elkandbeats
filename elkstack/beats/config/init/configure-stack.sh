#!/bin/bash



# Import the standard Beats dashboards.
/usr/share/metricbeat/scripts/import_dashboards \
  -beat '' \
  -file /usr/share/metricbeat/beats-dashboards-${ELASTIC_VERSION}.zip \
  -es http://elasticsearch:9200 \
  -user elastic \
  -pass ${ES_PASSWORD}


# Set the default index pattern.
curl -s -XPUT http://elastic:${ES_PASSWORD}@elasticsearch:9200/.kibana/config/${ELASTIC_VERSION} \
     -d "{\"defaultIndex\" : \"${DEFAULT_INDEX_PATTERN}\"}"


