#!/bin/bash
./testscript.sh;
echo result $? $(hostname)|nc 192.168.0.7 18081;
rm ./testscript.sh
