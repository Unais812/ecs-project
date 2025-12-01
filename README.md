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





# Terraform 
- Amazon S3 bucket as a backend to prevent collaboration chaos
- Modules for a clean directory structure
- Consistent use of variables | **DRY principle**


# CI/CD
- Pipeline uses manual workflow to prevent unecessary changes
- Builds, Tags, Pushes Dockerfile to ECR repo automated with GitHub actions
- Utilises GitHub secrets to hide confidential information


# Docker
- Multistage build to ensure a lightweight image for faster deployment
- Cut unecessary source code in runtime stage for small image size
- Ensures smooth deployment across all environments to prevent "it works on my machine" problems





