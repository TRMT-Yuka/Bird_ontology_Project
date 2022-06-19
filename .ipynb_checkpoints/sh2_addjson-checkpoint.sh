#!/bin/bash
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/Q742292 | jq . > data_json/Q742292.json
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/Q255503 | jq . > data_json/Q255503.json
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/Q7432 | jq . > data_json/Q7432.json
curl -sLH 'Accept: application/json' http://www.wikidata.org/entity/Q5113 | jq . > data_json/Q5113.json