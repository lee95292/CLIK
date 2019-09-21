#!/bin/bash
CLIK_ADDR="192.168.0.254"
PORT="18081"

echo request $(hostname)|nc ${CLIK_ADDR} ${PORT}
