# AWS Custom VPC Infrastructure as Code (Terraform)

Provisioning secure and custom cloud networking architecture on Amazon Web Services using HashiCorp Terraform.

## Architecture Overview
* **Virtual Private Cloud (VPC):** Custom VPC configured with customized CIDR blocks (`10.0.0.0/16`).
* **Subnets:** Configured public and private subnets to segregate external-facing workloads from internal services.
* **Gateways:** Internet Gateway (IGW) for public internet access and NAT Gateway routing.
* **Security Controls:** Custom Security Groups regulating inbound and outbound traffic.

## Tech Stack
* **Infrastructure as Code:** Terraform (HCL)
* **Cloud Provider:** AWS (VPC, Subnets, Route Tables, Security Groups, Internet & NAT Gateways)

## Usage
1. Initialize Terraform:
   ```bash
   terraform init