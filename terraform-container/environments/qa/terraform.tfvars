ami           = "ami-qa-456"
instance_name = "qa-ec2"
instance_type = "t2.medium"
bucket_name   = "qa-bucket"
table_name    = "qa-table"
hash_key      = "qa-id"
tags_ec2 = {
  Environment = "qa"
  Project     = "example_qa-ec2"
}
tags_s3 = {
  Environment = "qa"
  Project     = "example_qa-s3"
}
tags_dynamodb = {
  Environment = "qa"
  Project     = "example_qa-dynamodb"
}
