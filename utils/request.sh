#!/bin/bash
# Param Mapping / $1 - Assignment number

CLIK_ADDR="192.168.0.254"
PORT="18081"

echo request $(hostname) $1 |nc ${CLIK_ADDR} ${PORT}
