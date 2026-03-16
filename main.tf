module "dev-infra" {
    source = "./infra-app"
    env ="dev"
    instance_count = 1
    ec2_ami_id = "ami-02dfbd4ff395f2a1b"
    instance_type = "t3.small"
    bucket_name = "s3-infra-bucket-tf-208268"
    hash_key = "studentID"
}


module "prd-infra" {
    source = "./infra-app"
    env = "prd"
    instance_count =2
    ec2_ami_id = "ami-02dfbd4ff395f2a1b"
    instance_type = "t3.micro"
    bucket_name = "s3-infra-bucket-tf-208268"
    hash_key = "studentID"

}

module "stg-infra" {
    source = "./infra-app"
    env = "stg"
    instance_count =1
    ec2_ami_id = "ami-02dfbd4ff395f2a1b"
    instance_type = "t3.small"
    bucket_name = "s3-infra-bucket-tf-208268"
    hash_key = "studentID"

}