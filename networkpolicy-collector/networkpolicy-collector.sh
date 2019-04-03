#!/bin/sh

echo "Start infinite while loop to collect NetworkPolicies"

while true
do 
  i="0"
  LENGTH="0"
  
  echo "Get NetworkPolicies via kubectl"
  /usr/local/bin/kubectl --kubeconfig=$KUBECONFIG_PATH get networkpolicies --all-namespaces -o json > /home/collector/all-networkpolicies.json
  
  echo "Determin length of items array in file with all NetworkPolicies"
  LENGTH=$(jq '.items | length' /home/collector/all-networkpolicies.json)

  echo "Create directory for temporary store of files with single NetworkPolicies"
  mkdir -p /home/collector/single-networkpolicies

  echo "Start while loop to extract single NetworkPolicies and store them in MongoDB"
  while [ $i -lt $LENGTH ]
    do
      echo "Extract single NetworkPolicy"
      jq ".items[$i]" /home/collector/all-networkpolicies.json > /home/collector/single-networkpolicies/np$i.json
      
      echo "Store single NetworkPolicy in MongoDB"
      mongoimport --host $MONGODB_HOST --port $MONGODB_PORT --db k8sresources --collection networkpolicies --file /home/collector/single-networkpolicies/np$i.json
      i=$[$i+1]
    done
  echo "Remove directory for temporary store of files with single NetworkPolicies"  
  rm -rf /home/collector/single-networkpolicies

  echo "Remove all-networkpolicies.json file"
  rm /home/collector/all-networkpolicies.json

  echo "Wait $INTERVAL seconds until the next run"
  sleep $INTERVAL
done