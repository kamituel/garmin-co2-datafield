#!/usr/bin/env bash

java -jar "${GARMIN_SDK_PATH}/bin/monkeybrains.jar" \
  -o target/CO2.iq \
  -e \
  -w \
  -y developer_key.der \
  -r \
  -f monkey.jungle
