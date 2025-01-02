sshpubkey = file("../pubkey.txt")

region = "us-west-2"

owners = "" # "AWS Account ID for Canonical (Ubuntu)"

ubuntu20_name = "prodvm"

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
