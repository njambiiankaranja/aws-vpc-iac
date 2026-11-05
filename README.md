# AWS Custom VPC with Terraform

Infrastructure as Code project that uses Terraform to build a custom AWS network: a VPC with a public and a private subnet, internet access for the public side, and outbound-only access for the private side through a NAT Gateway.

---

## Architecture

```text
                    Internet
                       |
               Internet Gateway
                       |
 VPC 10.0.0.0/16       |
 +---------------------+---------------------------+
 |  Public subnet 10.0.1.0/24                      |
 |  - route 0.0.0.0/0 -> Internet Gateway          |
 |  - NAT Gateway (with Elastic IP)                |
 |                      |                          |
 |  Private subnet 10.0.3.0/24                     |
 |  - route 0.0.0.0/0 -> NAT Gateway               |
 |  - no inbound path from the internet            |
 |                                                 |
 |  Web security group                             |
 |  - HTTP (80) from anywhere                      |
 |  - SSH (22) from your own IP only               |
 +-------------------------------------------------+
```

---

## What It Provisions

| Resource | Details |
|---|---|
| VPC | `10.0.0.0/16` with DNS support and DNS hostnames enabled |
| Public subnet | `10.0.1.0/24` in `us-east-1a`, auto-assigns public IPs |
| Private subnet | `10.0.3.0/24` in `us-east-1a`, no public IPs |
| Internet Gateway | Gives the public subnet internet access |
| NAT Gateway and Elastic IP | Placed in the public subnet so private resources can reach the internet without being reachable from it |
| Route tables | Public routes through the Internet Gateway, private routes through the NAT Gateway |
| Web security group | HTTP from anywhere and SSH only from your IP, ready to attach to instances you launch in the VPC |

All resources are tagged with `Project` and `ManagedBy = Terraform` through the provider's default tags.

---

## Configuration

| Variable | Default | Description |
|---|---|---|
| `my_ip` | none, required | Your public IP in CIDR form (for example `203.0.113.25/32`), allowed to SSH in. Rejects invalid CIDRs and `0.0.0.0/0` |
| `aws_region` | `us-east-1` | Region to deploy into |
| `availability_zone` | `us-east-1a` | Availability zone for both subnets |
| `name_prefix` | `cloud-vpc` | Prefix for resource names and the `Project` tag |
| `vpc_cidr` | `10.0.0.0/16` | VPC CIDR block |
| `public_subnet_cidr` | `10.0.1.0/24` | Public subnet CIDR block |
| `private_subnet_cidr` | `10.0.3.0/24` | Private subnet CIDR block |

### Outputs

| Output | Description |
|---|---|
| `vpc_id` | ID of the VPC |
| `public_subnet_id` | ID of the public subnet |
| `private_subnet_id` | ID of the private subnet |
| `nat_gateway_public_ip` | Public IP that outbound traffic from the private subnet appears to come from |
| `web_security_group_id` | ID of the web security group |

---

## Project Structure

```text
aws-vpc-iac/
├── main.tf        # VPC, subnets, gateways, route tables, security group
├── variables.tf   # Input variables and my_ip validation
├── outputs.tf     # VPC, subnet, NAT and security group outputs
├── providers.tf   # Terraform and AWS provider versions, region, default tags
└── README.md
```

---

## Usage

Prerequisites: an AWS account with the AWS CLI configured, and Terraform `>= 1.0.0`.

Create a `terraform.tfvars` file (ignored by Git) with your own public IP:

```hcl
my_ip = "203.0.113.25/32"   # your public IP followed by /32
```

Then deploy:

```bash
terraform init
terraform plan
terraform apply
```

### Cost note

The NAT Gateway and its Elastic IP are billed while they exist, whether or not they carry traffic. Destroy the stack when you are done:

```bash
terraform destroy
```