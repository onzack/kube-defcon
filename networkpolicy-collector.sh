#!/bin/sh

echo "Start infinite loop to collect network policies."

while true
do 
  i="0"
  LENGTH="0"

  /usr/local/bin/kubectl get networkpolicies --all-namespaces -o json > /home/collector/all-networkpolicies.json
  LENGTH=$(jq '.items | length' /home/collector/all-networkpolicies.json)

  mkdir -p /home/collector/single-networkpolicies

  while [ $i -lt $LENGTH ]
    do
      jq ".items[$i]" /home/collector/all-networkpolicies.json > /home/collector/single-networkpolicies/np$i.json
      i=$[$i+1]
    done
  rm -rf /home/collector/single-networkpolicies
  sleep 5
done
