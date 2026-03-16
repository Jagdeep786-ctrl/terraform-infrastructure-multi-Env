# Terraform Multi-Environment AWS Infrastructure

## Project Overview

This project provisions **multi-environment cloud infrastructure** using **Terraform** on **AWS**.
The infrastructure is designed using **modular Terraform architecture** to deploy separate environments for **development (dev), staging (stg), and production (prd)**.

Each environment automatically provisions its own cloud resources with environment-specific naming and configuration.

The project demonstrates **Infrastructure as Code (IaC)** principles used in modern DevOps workflows.

---

# Technologies Used

* Terraform
* AWS EC2
* AWS S3
* AWS DynamoDB
* AWS VPC Networking
* Git / GitHub

---

# Architecture Overview

The infrastructure is deployed using a reusable Terraform module (`infra-app`).
Each environment calls the module with different parameters.

Environments created:

* dev (development)
* stg (staging)
* prd (production)

Example resource naming pattern:

dev-infra-app-instance
stg-infra-app-instance
prd-infra-app-instance

---

# Infrastructure Components

This project provisions the following AWS resources:

### Compute

* EC2 Instances

### Networking

* Virtual Private Cloud (VPC)
* Public Subnet
* Internet Gateway
* Route Table
* Route Table Association
* Security Group (HTTP + SSH access)

### Storage

* S3 Buckets for environment storage

### Database

* DynamoDB table

### Access

* SSH Key Pair for EC2 access

---

# Terraform Module Design

The `infra-app` module creates reusable infrastructure components such as:

* VPC
* Subnet
* Internet Gateway
* Route Table
* Security Groups
* EC2 Instances
* DynamoDB Table
* S3 Bucket

The root configuration deploys multiple environments using this module.

Example:

```
module "dev-infra" {
  source         = "./infra-app"
  env            = "dev"
  instance_count = 1
  instance_type  = "t3.small"
}
```

---

# Project Structure

```
Infrastructure_3_ENV
│
├── main.tf
├── providers.tf
├── variables.tf
│
└── infra-app
    ├── ec2.tf
    ├── s3.tf
    ├── dynamodb.tf
    └── variables.tf
```

**Root Module**

* Defines environments (dev, stg, prd)

**infra-app Module**

* Contains reusable infrastructure resources

---

# Key Terraform Concepts Demonstrated

This project demonstrates several important DevOps practices:

* Infrastructure as Code (IaC)
* Terraform modules
* Multi-environment deployments
* Dynamic resource configuration
* Variable-based infrastructure
* Conditional logic in Terraform
* Resource tagging
* Modular infrastructure architecture

Example conditional configuration:

```
volume_size = var.env == "prd" ? 10 : 8
```

Production instances receive larger storage automatically.

---

# How to Deploy

## 1 Clone Repository

```
git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
cd YOUR_REPOSITORY
```

## 2 Initialize Terraform

```
terraform init
```

## 3 Validate Configuration

```
terraform validate
```

## 4 Review Infrastructure Plan

```
terraform plan
```

## 5 Deploy Infrastructure

```
terraform apply
```

---

# Example Resources Created

After deployment, Terraform creates:

* VPC with CIDR `10.0.0.0/16`
* Public Subnet
* Internet Gateway
* Security Group (SSH + HTTP)
* EC2 instances based on environment configuration
* DynamoDB table
* S3 bucket for each environment

---

# Future Improvements

Potential improvements to extend this project:

* Terraform remote backend (S3 + DynamoDB state locking)
* CI/CD pipeline with GitHub Actions
* Load Balancer configuration
* Auto Scaling Groups
* Private subnets and NAT Gateway
* IAM roles and policies
* Monitoring with CloudWatch

---

# Author

Jagdeep Sodhi

---

# Purpose

This project was created to practice **Terraform Infrastructure as Code** and demonstrate **multi-environment cloud infrastructure deployment on AWS**.
