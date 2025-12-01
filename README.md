# Threat-Composer app deployed on ECS Fargate

## Overview
- Deployed on ECS Fargate
- Uses HTTPS encryption 
- Deployed in different AZs for high availability
- Docker multistage for a lightweight app
- CI/CD pipelines with GitHub actions to automate infra checks along with deploying the application


# Architecture Diagram

<img width="609" height="689" alt="Screenshot 2025-11-30 at 01 29 51" src="https://github.com/user-attachments/assets/13bd1530-992b-4f91-8830-5e74fedc19e1" />

## Features
- Uses an ALB to distribute load evenly
- HTTP-HTTPS redirection using an ALB listener
- Security groups to restrict complete access to other resources
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
        ├── acm/
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
