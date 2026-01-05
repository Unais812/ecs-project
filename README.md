# Prodcution grade ECS deployment

## Overview
This is a deployment of AWS threat composer tool on ECS using production grade scalable infrastructure, has many secure features such as non root user for Dockerfile, HTTPS traffic flow, IAM roles following principle of least privileged \
Automated infrastructure provisioning with terraform and CI/CD pipelines for streamlined process


# Architecture Diagram
<img width="640" height="668" alt="ECS arch diagram 1" src="https://github.com/user-attachments/assets/09e75a91-6d1a-403f-97b2-6ae5921a6995" />

## Features
- Deployed on ECS Fargate
- Uses HTTPS encryption 
- Deployed in different AZs for high availability
- Docker multistage for a lightweight app
- CI/CD pipelines with GitHub actions to automate infra checks along with deploying the application
- Uses route53 hosted zone + ACM allowing app to be reached on **https://tm.nginxunais.com**

# Directory Structure

```Terraform/
├── .github/
│   └── workflows/
│       ├── dockerpush.yaml
│      
│      
├── app/
│   └── Dockerfile
│
└── Terraform/
    ├── main.tf
    ├── provider.tf
    ├── variables.tf
    └── modules/
        ├── alb/
        ├── ecs/
        ├── route53/
        └── vpc/
```




# Terraform 
- Amazon S3 bucket as a backend to prevent collaboration chaos
- Modules for a clean directory structure
- Consistent use of variables | **DRY principle**


# CI/CD
<img width="1119" height="484" alt="Screenshot 2025-12-01 at 00 46 03" src="https://github.com/user-attachments/assets/4719ad14-4801-4687-a7cf-3fd4596e511e" />

- Pipeline uses manual workflow to prevent unecessary changes
- Builds, Tags, Pushes Dockerfile to ECR repo automated with GitHub actions
- Utilises GitHub secrets to hide confidential information


# Docker
- Multistage build to ensure a lightweight image resulting in a 90% smaller image size
- Ensures smooth deployment across all environments to prevent "it works on my machine" problems


# Local App Setup 💻
```
yarn install
yarn build
yarn global add serve
serve -s build

Then visit:
http://localhost:3000
```


# Application hosted on tm.nginxunais.com


<img width="1512" height="982" alt="Screenshot 2025-11-29 at 12 10 47" src="https://github.com/user-attachments/assets/b52263d2-4cb4-4a4d-8b50-521086b48b14" />
