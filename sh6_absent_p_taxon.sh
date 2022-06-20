#!/bin/bash
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/Q52762328 | jq . > data_json_13/Q52762328.json
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/Q23809240 | jq . > data_json_13/Q23809240.json
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/None | jq . > data_json_13/None.json
