ami           = "ami-prod-789"
instance_name = "prod-ec2"
instance_type = "t3.micro"
bucket_name   = "prod-bucket"
table_name    = "prod-table"
hash_key      = "prod-id"
tags_ec2 = {
  Environment = "prod"
  Project     = "example_prod-ec2"
}
tags_s3 = {
  Environment = "prod"
  Project     = "example_prod-s3"
}
tags_dynamodb = {
  Environment = "prod"
  Project     = "example_prod-dynamodb"
}
