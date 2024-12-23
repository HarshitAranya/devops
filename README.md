# devops
DevOps

How this repo will work:

1. From GitHub action, use the .aws_ec2.yaml. It will use access keys from secret variables and terraform/
   awsec2.tf, pubkey.txt to create an ec2 instance on aws.
2. The created ec2 instance will have - terraform, aws cli, Ansible and git. It will use hostname as AWSControllerVM
3. On AWSControllerVM use git clone "this repo" and terraform/project_onetime/main.tf
4. main.tf will call terraform modules and it will create 2 vms in VPC. One is for jenkins master and other is for slave.
5. Run ansible/jenkinsPlay.yaml to configure both vms as per out requirements.
6. Set up the jenkins for CI pipeline by refering the code from JenkinsPipeLine/Jenkinsfile.
7. ??
