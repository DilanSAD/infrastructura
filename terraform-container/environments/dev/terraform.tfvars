ami           = "ami-dev-123"
instance_name = "dev-ec2"
instance_type = "t2.micro"
bucket_name   = "dev-bucket"
table_name    = "dev-table"
hash_key      = "dev-id"
tags_ec2 = {
  Environment = "dev"
  Project     = "example_dev-ec2"
}
tags_s3 = {
  Environment = "dev"
  Project     = "example_dev-s3"
}
tags_dynamodb = {
  Environment = "dev"
  Project     = "example_dev-dynamodb"
}
