# flask-api-revolut
Home assignment for Revolut DevOps Engineer position.

## Objectives
1. Design and code a simple application that exposes specific API endpoints.
2. Produce a system diagram of the solution deployed to the cloud.
3. Write configuration scripts for building and no-downtime production deployment.

## Tools of choice
#### Application
- Flask - Super for developing simple APIs.   
- Docker - For deployment velocity & ease of maintenance.

#### Cloud Provider
- AWS
  - Compute - ECS Fargate
  - Storage - EFS

#### Deployment
- Github Actions - free for public repositories, and having not used it before, I was very impressed.

#### Infrastructure Provisioning
- Terraform.


#### 
## System Design
A sketch of the cloud architecture, deployed using Terraform.

TODO: Sketch

## Considerations

### Monitoring
With ECS, we can easily set up monitoring alongside in the form of AWS managed Cloudwatch or containerized Prometheus or other.

### Data Persistence
Considered using DynamoDB but opted for EFS for simplicity. DynamoDB would involve setting up VPC Endpoints whereas with EFS we simply define mount points in the private subnets where the ECS containers live. 

### Scalability
The service is highly scalable thanks to ECS. We can define how many containers we'd like to be running at any one time. This can be adjusted dynamically by introducing auto-scaling to match traffic demands.

### Availability
The service is spread across three AZs in a single region, each with an X number of containers behind an ALB. It is reliable to an extent, but it is not uncommon for entire regions to go down. We can increase availability by multiple factors by going multi-region and even multi-cloud.

### Code Deployments
Each time a code change is pushed to the remote repo, Github Actions rebuilds the image and pushes to a private repository in ECR. We can also add a task into the workflow to deploy the new task definition - https://github.com/aws-actions/amazon-ecs-deploy-task-definition.

TODO: Finish considerations

### Application Code
### Infrastructure design

### Cost Efficiency
Fargate - serverless, s3 for json storage, but potentially sacrificing speed

### Toolstack

## Areas of Improvement
- Modularize Terraform resources
- Introduce a monitoring stack
- Auto-scaling
- Switch to DynamoDB for JSON users storage
- Multi-cloud with a CDN on top
- Limit security group CIDRs to defined subnets
- Variablize Terraform more!
