#!/bin/sh

P=`pwd`

echo ""
./mdump -p0 -Q2 -r100000 239.101.3.10 12000 10.29.3.42 &
PID=$!
ssh orion $P/msend -q -m1472 -b20000 -n1 -p2 239.101.3.10 12000 15 10.29.3.43
kill -ALRM $PID
wait  # for mdump to finish

echo ""
./mdump -p0 -Q2 -r100000 239.101.3.10 12000 10.29.3.42 &
PID=$!
ssh orion $P/msend -q -m215 -b20000 -n1 -p2 239.101.3.10 12000 15 10.29.3.43
kill -ALRM $PID
wait  # for mdump to finish

echo ""
./mdump -p0 -Q2 -r100000 239.101.3.10 12000 10.29.3.42 &
PID=$!
ssh orion $P/msend -q -m214 -b20000 -n1 -p2 239.101.3.10 12000 15 10.29.3.43
kill -ALRM $PID
wait  # for mdump to finish

echo ""
./mdump -p0 -Q2 -r100000 239.101.3.10 12000 10.29.3.42 &
PID=$!
ssh orion $P/msend -q -m1 -b20000 -n1 -p2 239.101.3.10 12000 15 10.29.3.43
kill -ALRM $PID
wait  # for mdump to finish

echo ""
./mdump -p0 -Q2 -r200000 239.101.3.10 12000 10.29.3.42 &
PID=$!
ssh orion $P/msend -q -m1472 -b20000 -n1 -p2 239.101.3.10 12000 15 10.29.3.43
kill -ALRM $PID
wait  # for mdump to finish

echo ""
./mdump -p0 -Q2 -r200000 239.101.3.10 12000 10.29.3.42 &
PID=$!
ssh orion $P/msend -q -m215 -b20000 -n1 -p2 239.101.3.10 12000 15 10.29.3.43
kill -ALRM $PID
wait  # for mdump to finish

echo ""
./mdump -p0 -Q2 -r200000 239.101.3.10 12000 10.29.3.42 &
PID=$!
ssh orion $P/msend -q -m214 -b20000 -n1 -p2 239.101.3.10 12000 15 10.29.3.43
kill -ALRM $PID
wait  # for mdump to finish

echo ""
./mdump -p0 -Q2 -r200000 239.101.3.10 12000 10.29.3.42 &
PID=$!
ssh orion $P/msend -q -m1 -b20000 -n1 -p2 239.101.3.10 12000 15 10.29.3.43
kill -ALRM $PID
wait  # for mdump to finish

exit
