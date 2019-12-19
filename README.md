# kube-defcon
A tool to visualize network policy information from the Kubernetes Master API

This project is new, more and detailed information will follow in the future.

# Idea
![A Sample Graph for the idea visualization ](https://github.com/dmlabs/kube-defcon/blob/master/kube-defcon.png)

kube-defcon should be usable on every Kubernetes cluster with a network plugin that supports network policies.  
NetworkPolicies are collected simply with the `kubectl get netpol --all-namespaces` command.

# Motivation
As far as I know, there are no tools out there to visualize Kubernetes NetworkPolicies with just the information form the Kubernetes Master API, without the use of tools like Twistlock.  
I use NetworkPolicies with the Canal network plugin, but I am missing something to display the NetworkPolicis in a graph ore something similar, to get a quick overview, was is implemented.

If someone knows such a tool, pleas let me know!

# Update
This project is paused in favor of this project: [dmlabs/kube-scout](https://github.com/dmlabs/kube-scout)
