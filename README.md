# kuberecon
A tool to visualize native information from the Kubernetes Master API

This project was created a few moments ago and more information will follow...

# Idea
![A Sample Graph for the idea visualization ](https://github.com/dmlabs/kuberecon/blob/master/kuberecon.png)

# NetworkPolicy Collector
## Comment
For the moment, the NetworkPolicy Collector is cept as simple as possible with just a few bash scripts.

## Start the NetworkPolicy Collector
### Needed environment variables
* KUBECONFIG_PATH -> The path to the kubectl config file that is a bind mount into the container
* MONGODB_HOST -> The FQDN or IP of the MongoDB Host
* MONGODB_PORT -> The Port on which the MongoDB is listening, like 27017
* INTERVAL -> The time in seconds between two runs of the networkpolicy-collector, like 20 for 20 seconds

### Start
``` 
sudo docker run -tid --name networkpolicy-collector \
  -e KUBECONFIG_PATH="/home/collector/.kube/config \
  -e MONGODB_HOST="localhost" \
  -e MONGODB_PORT="27017" \
  -e INTERVAL="20" \
  kuberecon-networkpolicy-collector:v0.0.1
``` 

