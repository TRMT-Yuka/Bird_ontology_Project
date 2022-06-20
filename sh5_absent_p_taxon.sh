#!/bin/bash
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/Q134143 | jq . > data_json_12/Q134143.json
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/None | jq . > data_json_12/None.json
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/Q1209254 | jq . > data_json_12/Q1209254.json
