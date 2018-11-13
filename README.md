# terraform-gcp-simpleVPC

A very simple Virtual Private Cloud (VPC) in Google Cloud Platform (GCP) defined using Terraform Hashicorp Configuration Language (HCL).

The VPC has a single point-of-entry (POE), a reverse proxy server instance. The reverse proxy routes traffic to a load balancer which in-turn routes traffic to a managed instance group. The managed instance group acts as the appserver.

## Project Objectives

Use Terraform to create the following in GCP: a VPC and a reverse proxy.

* The VPC architecture should resemble: Internet --> Nginx Reverse Proxy --> Load Balancer --> Managed Instance Group
* The reverse proxy should...
** the only resource within the VPC that is accessible to the internet
** have nginx installed and running
** be accessible on TCP ports _22_, _80_, and _443_
** redirect port _80_ traffic to port _443_ (i.e., no content should be served from port 80)
** have a viable SSL certificate
** serve custom content other than the nginx default

Additionally...
* use a configuration manager to configure the nginx reverse proxy
* resist using Terraform to manage deployments
* Use the GCP equivalent of AWS Code* to configure a CI/CD pipeline


