# AWS VPC Infrastructure (IaC)

## Overview
This project provisions a secure, production-grade Custom Virtual Private Cloud (VPC) on AWS using Terraform (Infrastructure as Code) and automates its deployment via GitHub Actions (CI/CD Pipeline).

## Architecture Design
* VPC CIDR: 10.0.0.0/16
* Subnets: Public and Private subnets across multiple Availability Zones.
* Gateways: Internet Gateway (IGW) and NAT Gateway.

## Tools & Technologies Used
* Cloud Provider: Amazon Web Services (AWS)
* Infrastructure as Code: HashiCorp Terraform
* CI/CD Automation: GitHub Actions
* Version Control: Git & GitHub