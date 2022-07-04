#!/bin/bash
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/Q160830 | jq . > data_json_13/Q160830.json
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/Q2043179 | jq . > data_json_13/Q2043179.json
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/None | jq . > data_json_13/None.json
