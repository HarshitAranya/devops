sshpubkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCx2zU/bpj/7zmX4rgV8hKZSrz/6c4cuh5Uq4YlnFnzF76hRyQ3f7QtDTMH7Bue/iBuGjZlQ85QvSF3/38iu4dg6xBxecHxJyIwSPTczAMUuDFeV0gPuIIzhSbUvSkr+9N5RoyBDsm/bGEU57SElx+cQ0dMGE2RNBR5mohuopGBqXWFdn5QMUk11csSnYayU0UgB2JVFxPfZqmMNxXQkBslMn3JpXKI+uVOiQK8Ql5EyW0FxyEWb6hfIU2MKUUO2rB5ujysEgFrhTQOo6afmYNxa8iiqMhk1WaWiimKSbd8gVjwrKB9HsFRvRajjFOnB6qqervZ9/E6xLj5+XxlDdotT+25Qno3LrsQ4yntC+7TY6FspkwN0c4OM3cmKHGOEhrmeiPQZyWLytaFT01duf88vEu7/TXqx4woBGnzMAcYUMKMUjC0F9YZwhCieAxVECTIlWHQUZghCqTJsmeDQVrpL+Xj7POO8bGJ55nQQngpxGVMAWN1A9ol8QdZGGiM2MU= mydomain\\user.name@hostname"

region = "us-west-2"

owners = "" # "AWS Account ID for Canonical (Ubuntu)"

slave_name = "JenSlave"
master_name = "JenMaster"


SUB_Tag_Name = ["SUB-1-VPCIP8000N8", "SUB-2-VPCIP8000N8", "SUB-3-VPCIP8000N8", "SUB-4-VPCIP8000N8"] #index 0 1 2 3

route_name = "Route-VPCIP8000N8"

ig_name     = "IG_VPCIP8000N8"

vpc_cidr = "172.16.0.0/16"

SUB_cidr_block = ["172.16.0.0/19", "172.16.32.0/19", "172.16.64.0/19", "172.16.96.0/19"] 

ICMP-description = ["VPC", "Allow_ICMP_for_All", "IGW"]

TCP-description= {
    "TCP-desc"     = "Allow TCP for All"
    "TCP_Out-desc" = "Allow TCP_Out for All"
}
