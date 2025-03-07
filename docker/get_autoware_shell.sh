#!/usr/bin/env bash

# Check if ROS_DOMAIN_ID is set; exit if undefined
if [[ -z "${ROS_DOMAIN_ID}" ]]; then
    echo "Error: ROS_DOMAIN_ID is not set. Please export it before running this script."
    echo "       export ROS_DOMAIN_ID=<my_unique_id>"
    exit 1
fi

docker exec -it --user "$(id -un)" autoware_tartan bash
