#!/bin/bash
# Usage: usergen <number>
COUNTER=0
while [  $COUNTER -lt $1 ]; do
    echo user${COUNTER},user${COUNTER}@praqma.com
    let COUNTER=COUNTER+1 
done
