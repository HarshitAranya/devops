# devops
DevOps

How this repo will work:

1. From GitHub action, use the .aws_ec2.yaml. It will use access keys from secret variables and
   terraform/awsec2.tf, pubkey.txt to create an ec2 instance on aws.
2. The created ec2 instance will have - terraform, aws cli, Ansible and git. 
   It will use hostname as AWSControllerVM
3. On AWSControllerVM use git clone "this repo" and terraform/project_onetime/main.tf
4. main.tf will call terraform modules and it will create 2 vms in VPC. One is for jenkins 
   master and other is for slave.
5. Run ansible/jenkinsPlay.yaml to configure both vms as per out requirements.
6. Set up the jenkins for CI pipeline by refering the code from JenkinsPipeLine/Jenkinsfile.
7. The pipeline will use Dockerfile from tire3_WebApp and build the images and push it to docker repo.
8. Now you can write CD part to deploy this application.
9. In this case we will use ec2 instance and Jenkinsfile from CD_Jenkinsfile.
10. Create the secrets variables in Jenkins --> run the CD pipeline --> jenkinsfile will read the secrets from secrets
   variables --> and pars it to ansible/prodconfig.yaml --> this will configure prod vm.
11. Then pipeline will run the docker/2_DB-docker-compose.yml it will use local env variables created by 
   prodconfig.yaml before.

--In case privet repo | Store Docker Credentials in Jenkins
Go to Jenkins Dashboard > Manage Jenkins > Manage Credentials.
Add a new credential:
Kind: Username with password
Scope: Global
ID: docker-credentials (or any name you prefer)
Username: Your Docker username (e.g., tomdick)
Password: Your Docker password or Personal Access Token (PAT).

