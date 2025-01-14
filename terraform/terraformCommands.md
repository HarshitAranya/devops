terraform apply
terraform init
terraform state list
echo resourceName.id | terraform console
$MYVAR_ID=$(echo resourceName.id | terraform console)
terraform state rm resourceName1 resourceName2 resourceName3

Migrating Terraform deprecated resources --
step0 - take id of all the deprecated resources
step1 - remove from terrafomr.state
step2 - update main.tf
step3 - import

terraform import new_resourceName1 $MYVAR_ID
terraform state list
terraform plan

Summary of Meta-Arguments:
Meta-Argument	Purpose
depends_on	Creates explicit dependencies.
provider	Specifies which provider to use.
count	Creates multiple instances of a resource.
for_each	Creates multiple instances with more control than count.
lifecycle	Customizes creation, update, and deletion behaviors.
provisioner	Runs commands during resource lifecycle events.
connection	Defines connection settings for remote provisioners.

terraform workspace list
terraform workspace new dev
terraform workspace show

export TF_VAR_PASSWORD=myPassw0rd
PASSWORD will be variable in tf file

terraform apply -auto-approve -state=my.tfstate
terraform providers

D:\learningTerraform> tf state list
github_repository.githubRepo
D:\learningTerraform> echo github_repository.githubRepo.id | tf console
"fromTerraform"
D:\learningTerraform> tf import github_repository.githubRepo fromTerraform
